import Foundation

/// A flare/bazel configuration, used for remote caching without a Tuist Cloud instance.
public struct Flare: Equatable, Hashable {
    /// The base URL that points to the Flare server
    public let url: String

    /// The auth token (local usage only)
    public let authToken: String

    /// Initializes an instance of Flare.
    /// - Parameters:
    ///   - url: gRPC server URL.
    ///   - authToken: local-only auth token (work in progress)
    public init(url: String, authToken: String) {
        self.url = url
        self.authToken = authToken
    }
}
