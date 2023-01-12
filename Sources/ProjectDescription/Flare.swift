import Foundation

/// A flare/bazel configuration, used for remote caching without a Tuist Cloud instance.
public struct Flare: Codable, Equatable {
    /// The base URL that points to the Flare server
    public let url: String

    /// The auth token (local usage only)
    public let authToken: String

    /// Returns a flare configuration.
    /// - Parameters:
    ///   - url: Base URL to the Cloud server.
    ///   - authToken: Auth token, suitable for local connections only; todo: get this value another way
    /// - Returns: A Flare instance.
    public static func flare(url: String, authToken: String) -> Flare {
        Flare(url: url, authToken: authToken)
    }
}
