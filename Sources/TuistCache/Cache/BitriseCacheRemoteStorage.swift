import BazelProto
import Foundation
import GRPC
import NIO
import NIOCore
import NIOHPACK
import NIOPosix
import SwiftProtobuf
import TSCBasic
import TuistCore
import TuistGraph
import TuistSupport

typealias KVStorageClient = KvStorage_KVStorageAsyncClient
typealias CapabilitiesClient = Build_Bazel_Remote_Execution_V2_CapabilitiesAsyncClient
typealias CASClient = Build_Bazel_Remote_Execution_V2_ContentAddressableStorageAsyncClient
typealias FindMissingReq = Build_Bazel_Remote_Execution_V2_FindMissingBlobsRequest
typealias FindMissingRes = Build_Bazel_Remote_Execution_V2_FindMissingBlobsResponse
typealias ReqMetadata = Build_Bazel_Remote_Execution_V2_RequestMetadata

enum FlareCacheRemoteStorageError: FatalError, Equatable {
    case connectionFailed

    var type: ErrorType {
        switch self {
        case .connectionFailed: return .abort
        }
    }

    var description: String {
        switch self {
        case .connectionFailed:
            return "The backend gRPC cache service is unavailable, or the connection failed."
        }
    }
}

public final class BitriseCacheRemoteStorage: CacheStoring {
    // MARK: - Attributes

    private let fileArchiverFactory: FileArchivingFactorying
    private let cacheDirectoriesProvider: CacheDirectoriesProviding
    private let bitriseConfig: Bitrise
    private let group: EventLoopGroup = PlatformSupport.makeEventLoopGroup(loopCount: 100)
    private var channel: GRPCChannel?
    private var casClient: CASClient?
    private var kvClient: KVStorageClient?
    private var capClient: CapabilitiesClient?
    private var validCapabilities: Bool?
    private let instanceName = "tuist"
    private let sessionId = UUID().uuidString
    private let defaultTimeout = TimeAmount.seconds(30)
    private let uploadTimeout = TimeAmount.minutes(5)

    // MARK: - Init

    public convenience init(
        bitriseConfig: Bitrise,
        cacheDirectoriesProvider: CacheDirectoriesProviding
    ) throws {
        try self.init(
            bitriseConfig: bitriseConfig,
            fileArchiverFactory: FileArchivingFactory(),
            cacheDirectoriesProvider: cacheDirectoriesProvider
        )
    }

    init(
        bitriseConfig: Bitrise,
        fileArchiverFactory: FileArchivingFactorying,
        cacheDirectoriesProvider: CacheDirectoriesProviding
    ) throws {
        self.bitriseConfig = bitriseConfig
        self.fileArchiverFactory = fileArchiverFactory
        self.cacheDirectoriesProvider = cacheDirectoriesProvider
        try initClients()
    }

    deinit {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            try? self.group.syncShutdownGracefully()
            try? self.channel?.close().wait()
        }
    }

    // MARK: - CacheStoring

    public func exists(name: String, hash: String) async throws -> Bool {
        guard let client = casClient else {
            throw FlareCacheRemoteStorageError.connectionFailed
        }
        let req: FindMissingReq = make {
            $0.instanceName = self.instanceName
            $0.blobDigests = [make {
                $0.hash = hash
            }]
        }
        if try await !client.findMissingBlobs(req).missingBlobDigests.isEmpty {
            return false
        }
        CacheAnalytics.addRemoteCacheTargetHit(name)
        return true
    }

    public func fetch(name: String, hash: String) async throws -> AbsolutePath {
        let resourceName = getResourceName(hash: hash)
        logger.info("Downloading cache artifact for target \(name) with hash \(hash).")
        let zipPath = AbsolutePath("/tmp/\(sessionId)_\(name)_\(hash).zip")
        try await readBlob(resourceName: resourceName, filePath: zipPath)
        do {
            return try unzip(zipPath: zipPath, hash: hash)
        } catch {
            logger.error("err unzipping: \(error)")
            throw error
        }
    }

    public func store(name _: String, hash: String, paths: [AbsolutePath]) async throws {
        let resourceName = getResourceName(hash: hash, upload: true)
        let archiver = try fileArchiverFactory.makeFileArchiver(for: paths)
        do {
            let destinationZipPath = try archiver.zip(name: hash)
            logger.trace("\(hash): destinationZipPath: \(destinationZipPath)")
            try await writeBlob(resourceName: resourceName, file: destinationZipPath)
        } catch {
            try archiver.delete()
            throw error
        }
    }

    // MARK: - Private

    private func getResourceName(hash: String, upload _: Bool = false) -> String {
        "\(instanceName)/\(hash)"
    }

    /// readBlob - Reads the specified blob by resource name off of the gRPC Bytestream and writes the results to a file at the specified path
    private func readBlob(resourceName: String, filePath: AbsolutePath) async throws {
        guard let client = kvClient else {
            logger.warning("readBlob: connection failed")
            throw FlareCacheRemoteStorageError.connectionFailed
        }

        let readReq: Google_Bytestream_ReadRequest = make {
            $0.resourceName = resourceName
        }

        let resStream = client.get(readReq)
        var blobData = Data()
        for try await blobChunk: Google_Bytestream_ReadResponse in resStream {
            blobData.append(blobChunk.data)
        }
        // computing the sha hash is slow-ish, remove later?
        let hh = resourceName.split(separator: "/")[1]
        logger.trace("\(hh): readBlob -> \(blobData.count) bytes; hash: \(SHA256().hashStr(blobData)), path: \(filePath)")
        try blobData.write(to: filePath.url, options: Data.WritingOptions.atomic)
    }

    private func writeBlob(resourceName: String, file: AbsolutePath) async throws {
        guard let client = kvClient else {
            logger.warning("writeBlob: connection failed")
            throw FlareCacheRemoteStorageError.connectionFailed
        }

        let (size, fileHash, reqs) = try writeRequests(resourceName: resourceName, file: file)
        let res = try await client.put(reqs, callOptions: callOptions(withTimeout: uploadTimeout))
        assert(Int64(size) == res.committedSize, "backend failed to commit all sent data")
        logger.trace("grpc put \(resourceName), hash: \(fileHash) - committed size: \(res.committedSize), expected size: \(size)")
    }

    // TODO: return an async iterable rather than copying the whole file around, though its already read in whole
    // from disk so not sure the impact this will have
    private func writeRequests(
        resourceName: String,
        file: AbsolutePath
    ) throws -> (Int, String, [Google_Bytestream_WriteRequest]) { // swiftlint:disable:this large_tuple
        let fileData = [UInt8](try FileHandler.shared.readFile(file))
        // expensive; hash is costly and also a redundant COPY, remove when debugging server responses isn't needed
        let fileHash = SHA256().hashStr(Data(fileData))
        let chunkSize = 1024 * 500 // 500K chunks
        var reqs: [Google_Bytestream_WriteRequest] = fileData.chunked(into: chunkSize).map { fileChunk in
            make {
                $0.resourceName = resourceName
                $0.data = Data(fileChunk)
            }
        }
        reqs[reqs.count - 1].finishWrite = true
        return (fileData.count, fileHash, reqs)
    }

    private func initClients() throws {
        if let target = URLComponents(string: bitriseConfig.url) {
            let secure: Bool = target.scheme != nil && target.scheme!.contains("grpcs")
            let tls = GRPCTLSConfiguration.makeClientConfigurationBackedByNIOSSL()
            let co = callOptions(withTimeout: defaultTimeout)

            do {
                channel = try GRPCChannelPool.with(
                    target: .host(target.host!, port: target.port ?? (secure ? 443 : 80)),
                    transportSecurity: secure ? .tls(tls) : .plaintext,
                    eventLoopGroup: group
                )
            } catch {
                logger.error("failed to initialze gRPC connection: \(error)")
                return
            }
            if let chan = channel {
                capClient = CapabilitiesClient(channel: chan, defaultCallOptions: co)
                casClient = CASClient(channel: chan, defaultCallOptions: co)
                kvClient = KVStorageClient(channel: chan, defaultCallOptions: co)
                try runBlocking {
                    do {
                        try await self.checkCapabilities()
                    } catch {
                        logger.error("failed to initialze gRPC connection and query cache capabilties: \(error)")
                        throw error
                    }
                }
            } else {
                logger.error("gRPC channel or call opts is nil")
            }
        }
    }

    private func callOptions(withTimeout timeout: TimeAmount) -> CallOptions {
        let reqMd: ReqMetadata = make {
            $0.toolInvocationID = sessionId
            $0.toolDetails = make {
                $0.toolName = "tuist"
            }
        }
        let mdString = try! reqMd.serializedData().base64EncodedString() // swiftlint:disable:this force_try
        var hdrs = [
            ("x-flare-buildtool", "tuist"),
            ("authorization", "Bearer \(bitriseConfig.authToken)"),
            ("build.bazel.remote.execution.v2.requestmetadata-bin", mdString),
        ]
        if !bitriseConfig.workspaceId.isEmpty {
            hdrs.append(("x-org-id", bitriseConfig.workspaceId))
        }

        return CallOptions(customMetadata: HPACKHeaders(hdrs), timeLimit: .timeout(timeout))
    }

    private func checkCapabilities() async throws {
        guard let client = capClient else {
            logger.warning("checkCapabilites: connection failed")
            throw FlareCacheRemoteStorageError.connectionFailed
        }
        let caps = try await client.getCapabilities(make {
            $0.instanceName = self.instanceName
        })
        let valid = (
            caps.hasCacheCapabilities &&
                caps.cacheCapabilities.hasActionCacheUpdateCapabilities &&
                caps.cacheCapabilities.actionCacheUpdateCapabilities.updateEnabled
        )
        validCapabilities = valid
        if !valid {
            logger.warning("invalid remote cache capabilities")
        }
    }

    public func unzip(zipPath: AbsolutePath, hash: String) throws -> AbsolutePath {
        logger.trace("\(hash): zipPath: \(zipPath)")
        let fileUnarchiver = try fileArchiverFactory.makeFileUnarchiver(for: zipPath)
        let unarchivedDirectory = try fileUnarchiver.unzip()
        logger.trace("\(hash): artifactPath (unarchived dir): \(unarchivedDirectory)")
        defer {
            try? fileUnarchiver.delete()
        }
        if artifactPath(in: unarchivedDirectory) == nil {
            throw CacheRemoteStorageError.artifactNotFound(hash: hash)
        }
        let archiveDestination = cacheDirectoriesProvider.cacheDirectory(for: .builds).appending(component: hash)
        logger.trace("\(hash): destination: \(archiveDestination)")
        if !FileHandler.shared.exists(archiveDestination.parentDirectory) {
            try FileHandler.shared.createFolder(archiveDestination.parentDirectory)
        }
        try FileHandler.shared.move(from: unarchivedDirectory, to: archiveDestination)
        logger.trace("\(hash): unzip OK: \(zipPath)")
        return artifactPath(in: archiveDestination)!
    }
}

/**
 proto initialization DSL
 - Parameter f: initializer function
 - Returns: the proto message with your changes applied
 */
func make<T: Message>(f: (inout T) -> Void) -> T { var t = T(); f(&t); return t }

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension SHA256 {
    func hashStr(_ data: Data) -> String {
        SHA256()
            .hash(ByteString(data))
            .contents
            .compactMap { String(format: "%02x", $0) }
            .joined()
    }
}

func runBlocking(task: @escaping () async throws -> Void) rethrows {
    Task {
        try await task()
    }
}
