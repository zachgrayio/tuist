import Foundation
import TuistCache
import TuistCloud
import TuistCore
import TuistGraph
import TuistLoader
import TuistSupport

enum CacheStorageProviderError: FatalError, Equatable {
    case tokenNotFound

    public var type: ErrorType {
        switch self {
        case .tokenNotFound:
            return .abort
        }
    }

    public var description: String {
        switch self {
        case .tokenNotFound:
            return "Token for tuist cloud was not found. Run `tuist cloud auth` to authenticate yourself."
        }
    }
}

final class CacheStorageProvider: CacheStorageProviding {
    private let config: Config
    private let cacheDirectoryProviderFactory: CacheDirectoriesProviderFactoring
    private let cloudAuthenticationController: CloudAuthenticationControlling
    private let bitriseAuthenticationController: BitriseAuthenticationControlling

    /// Cached response for list of storages
    @Atomic
    static var storages: [CacheStoring]?

    convenience init(
        config: Config
    ) {
        self.init(
            config: config,
            cacheDirectoryProviderFactory: CacheDirectoriesProviderFactory(),
            cloudAuthenticationController: CloudAuthenticationController(),
            bitriseAuthenticationController: BitriseAuthenticationController()
        )
    }

    init(
        config: Config,
        cacheDirectoryProviderFactory: CacheDirectoriesProviderFactoring,
        cloudAuthenticationController: CloudAuthenticationControlling,
        bitriseAuthenticationController: BitriseAuthenticationControlling
    ) {
        self.config = config
        self.cacheDirectoryProviderFactory = cacheDirectoryProviderFactory
        self.cloudAuthenticationController = cloudAuthenticationController
        self.bitriseAuthenticationController = bitriseAuthenticationController
    }

    func storages() throws -> [CacheStoring] {
        if let storages = Self.storages {
            logger.warning("setup Bitrise - init'd already")
            return storages
        }
        let cacheDirectoriesProvider = try cacheDirectoryProviderFactory.cacheDirectories(config: config)
        var storages: [CacheStoring] = [CacheLocalStorage(cacheDirectoriesProvider: cacheDirectoriesProvider)]
        var cloudCacheConfigured = false
        if let cloudConfig = config.cloud {
            if try cloudAuthenticationController.authenticationToken(serverURL: cloudConfig.url)?.isEmpty == false {
                let remoteStorage = CacheRemoteStorage(
                    cloudConfig: cloudConfig,
                    cloudClient: CloudClient(),
                    cacheDirectoriesProvider: cacheDirectoriesProvider
                )
                let storage = RetryingCacheStorage(cacheStoring: remoteStorage)
                storages.append(storage)
                cloudCacheConfigured = true
            } else {
                if cloudConfig.options.contains(.optional) {
                    logger
                        .warning(
                            "Authentication token for tuist cloud was not found. Skipping using remote cache. Run `tuist cloud auth` to authenticate yourself."
                        )
                } else {
                    throw CacheStorageProviderError.tokenNotFound
                }
            }
        }
        if !cloudCacheConfigured {
            if let effectiveConfig = bitriseAuthenticationController.effectiveBitriseConfig(config.bitrise) {
                logger.info("🤖 Bitrise remote cache enabled!", metadata: .success)

                let flareRemoteStorage = FlareCacheRemoteStorage(
                    bitriseConfig: effectiveConfig,
                    cacheDirectoriesProvider: cacheDirectoriesProvider
                )
                let storage = RetryingCacheStorage(cacheStoring: flareRemoteStorage)
                storages.append(storage)
                cloudCacheConfigured = true
            }
        }
        Self.storages = storages
        return storages
    }
}
