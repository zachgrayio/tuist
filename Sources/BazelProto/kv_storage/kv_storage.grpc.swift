//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: kv_storage/kv_storage.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `KvStorage_KVStorageClient`, then call methods of this protocol to make API calls.
public protocol KvStorage_KVStorageClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? { get }

  func get(
    _ request: Google_Bytestream_ReadRequest,
    callOptions: CallOptions?,
    handler: @escaping (Google_Bytestream_ReadResponse) -> Void
  ) -> ServerStreamingCall<Google_Bytestream_ReadRequest, Google_Bytestream_ReadResponse>

  func put(
    callOptions: CallOptions?
  ) -> ClientStreamingCall<Google_Bytestream_WriteRequest, Google_Bytestream_WriteResponse>
}

extension KvStorage_KVStorageClientProtocol {
  public var serviceName: String {
    return "kv_storage.KVStorage"
  }

  /// Server streaming call to Get
  ///
  /// - Parameters:
  ///   - request: Request to send to Get.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  public func get(
    _ request: Google_Bytestream_ReadRequest,
    callOptions: CallOptions? = nil,
    handler: @escaping (Google_Bytestream_ReadResponse) -> Void
  ) -> ServerStreamingCall<Google_Bytestream_ReadRequest, Google_Bytestream_ReadResponse> {
    return self.makeServerStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.get.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetInterceptors() ?? [],
      handler: handler
    )
  }

  /// Client streaming call to Put
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata, status and response.
  public func put(
    callOptions: CallOptions? = nil
  ) -> ClientStreamingCall<Google_Bytestream_WriteRequest, Google_Bytestream_WriteResponse> {
    return self.makeClientStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.put.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makePutInterceptors() ?? []
    )
  }
}

#if compiler(>=5.6)
@available(*, deprecated)
extension KvStorage_KVStorageClient: @unchecked Sendable {}
#endif // compiler(>=5.6)

@available(*, deprecated, renamed: "KvStorage_KVStorageNIOClient")
public final class KvStorage_KVStorageClient: KvStorage_KVStorageClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol?
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  public var interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the kv_storage.KVStorage service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

public struct KvStorage_KVStorageNIOClient: KvStorage_KVStorageClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol?

  /// Creates a client for the kv_storage.KVStorage service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#if compiler(>=5.6)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol KvStorage_KVStorageAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? { get }

  func makeGetCall(
    _ request: Google_Bytestream_ReadRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncServerStreamingCall<Google_Bytestream_ReadRequest, Google_Bytestream_ReadResponse>

  func makePutCall(
    callOptions: CallOptions?
  ) -> GRPCAsyncClientStreamingCall<Google_Bytestream_WriteRequest, Google_Bytestream_WriteResponse>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension KvStorage_KVStorageAsyncClientProtocol {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return KvStorage_KVStorageClientMetadata.serviceDescriptor
  }

  public var interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makeGetCall(
    _ request: Google_Bytestream_ReadRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncServerStreamingCall<Google_Bytestream_ReadRequest, Google_Bytestream_ReadResponse> {
    return self.makeAsyncServerStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.get.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetInterceptors() ?? []
    )
  }

  public func makePutCall(
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncClientStreamingCall<Google_Bytestream_WriteRequest, Google_Bytestream_WriteResponse> {
    return self.makeAsyncClientStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.put.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makePutInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension KvStorage_KVStorageAsyncClientProtocol {
  public func get(
    _ request: Google_Bytestream_ReadRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<Google_Bytestream_ReadResponse> {
    return self.performAsyncServerStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.get.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeGetInterceptors() ?? []
    )
  }

  public func put<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) async throws -> Google_Bytestream_WriteResponse where RequestStream: Sequence, RequestStream.Element == Google_Bytestream_WriteRequest {
    return try await self.performAsyncClientStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.put.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makePutInterceptors() ?? []
    )
  }

  public func put<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) async throws -> Google_Bytestream_WriteResponse where RequestStream: AsyncSequence & Sendable, RequestStream.Element == Google_Bytestream_WriteRequest {
    return try await self.performAsyncClientStreamingCall(
      path: KvStorage_KVStorageClientMetadata.Methods.put.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makePutInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct KvStorage_KVStorageAsyncClient: KvStorage_KVStorageAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: KvStorage_KVStorageClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#endif // compiler(>=5.6)

public protocol KvStorage_KVStorageClientInterceptorFactoryProtocol: GRPCSendable {

  /// - Returns: Interceptors to use when invoking 'get'.
  func makeGetInterceptors() -> [ClientInterceptor<Google_Bytestream_ReadRequest, Google_Bytestream_ReadResponse>]

  /// - Returns: Interceptors to use when invoking 'put'.
  func makePutInterceptors() -> [ClientInterceptor<Google_Bytestream_WriteRequest, Google_Bytestream_WriteResponse>]
}

public enum KvStorage_KVStorageClientMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "KVStorage",
    fullName: "kv_storage.KVStorage",
    methods: [
      KvStorage_KVStorageClientMetadata.Methods.get,
      KvStorage_KVStorageClientMetadata.Methods.put,
    ]
  )

  public enum Methods {
    public static let get = GRPCMethodDescriptor(
      name: "Get",
      path: "/kv_storage.KVStorage/Get",
      type: GRPCCallType.serverStreaming
    )

    public static let put = GRPCMethodDescriptor(
      name: "Put",
      path: "/kv_storage.KVStorage/Put",
      type: GRPCCallType.clientStreaming
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
public protocol KvStorage_KVStorageProvider: CallHandlerProvider {
  var interceptors: KvStorage_KVStorageServerInterceptorFactoryProtocol? { get }

  func get(request: Google_Bytestream_ReadRequest, context: StreamingResponseCallContext<Google_Bytestream_ReadResponse>) -> EventLoopFuture<GRPCStatus>

  func put(context: UnaryResponseCallContext<Google_Bytestream_WriteResponse>) -> EventLoopFuture<(StreamEvent<Google_Bytestream_WriteRequest>) -> Void>
}

extension KvStorage_KVStorageProvider {
  public var serviceName: Substring {
    return KvStorage_KVStorageServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Get":
      return ServerStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Google_Bytestream_ReadRequest>(),
        responseSerializer: ProtobufSerializer<Google_Bytestream_ReadResponse>(),
        interceptors: self.interceptors?.makeGetInterceptors() ?? [],
        userFunction: self.get(request:context:)
      )

    case "Put":
      return ClientStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Google_Bytestream_WriteRequest>(),
        responseSerializer: ProtobufSerializer<Google_Bytestream_WriteResponse>(),
        interceptors: self.interceptors?.makePutInterceptors() ?? [],
        observerFactory: self.put(context:)
      )

    default:
      return nil
    }
  }
}

#if compiler(>=5.6)

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol KvStorage_KVStorageAsyncProvider: CallHandlerProvider {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: KvStorage_KVStorageServerInterceptorFactoryProtocol? { get }

  @Sendable func get(
    request: Google_Bytestream_ReadRequest,
    responseStream: GRPCAsyncResponseStreamWriter<Google_Bytestream_ReadResponse>,
    context: GRPCAsyncServerCallContext
  ) async throws

  @Sendable func put(
    requestStream: GRPCAsyncRequestStream<Google_Bytestream_WriteRequest>,
    context: GRPCAsyncServerCallContext
  ) async throws -> Google_Bytestream_WriteResponse
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension KvStorage_KVStorageAsyncProvider {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return KvStorage_KVStorageServerMetadata.serviceDescriptor
  }

  public var serviceName: Substring {
    return KvStorage_KVStorageServerMetadata.serviceDescriptor.fullName[...]
  }

  public var interceptors: KvStorage_KVStorageServerInterceptorFactoryProtocol? {
    return nil
  }

  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "Get":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Google_Bytestream_ReadRequest>(),
        responseSerializer: ProtobufSerializer<Google_Bytestream_ReadResponse>(),
        interceptors: self.interceptors?.makeGetInterceptors() ?? [],
        wrapping: self.get(request:responseStream:context:)
      )

    case "Put":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<Google_Bytestream_WriteRequest>(),
        responseSerializer: ProtobufSerializer<Google_Bytestream_WriteResponse>(),
        interceptors: self.interceptors?.makePutInterceptors() ?? [],
        wrapping: self.put(requestStream:context:)
      )

    default:
      return nil
    }
  }
}

#endif // compiler(>=5.6)

public protocol KvStorage_KVStorageServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'get'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeGetInterceptors() -> [ServerInterceptor<Google_Bytestream_ReadRequest, Google_Bytestream_ReadResponse>]

  /// - Returns: Interceptors to use when handling 'put'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makePutInterceptors() -> [ServerInterceptor<Google_Bytestream_WriteRequest, Google_Bytestream_WriteResponse>]
}

public enum KvStorage_KVStorageServerMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "KVStorage",
    fullName: "kv_storage.KVStorage",
    methods: [
      KvStorage_KVStorageServerMetadata.Methods.get,
      KvStorage_KVStorageServerMetadata.Methods.put,
    ]
  )

  public enum Methods {
    public static let get = GRPCMethodDescriptor(
      name: "Get",
      path: "/kv_storage.KVStorage/Get",
      type: GRPCCallType.serverStreaming
    )

    public static let put = GRPCMethodDescriptor(
      name: "Put",
      path: "/kv_storage.KVStorage/Put",
      type: GRPCCallType.clientStreaming
    )
  }
}
