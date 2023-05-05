import Foundation

/// A Bitrise configuration, used for remote caching without a Tuist Cloud instance.
public struct Bitrise: Codable, Equatable {
    /// The base URL that points to the server
    public let url: String

    /// The Bitrise workspace ID this project is associated with (local usage only)
    public let workspaceId: String
    
    /// The auth token (local usage only)
    public let authToken: String

    /// Returns a Bitrise configuration.
    /// - Parameters:
    ///   - url: Base URL to the Cloud server.
    ///   - workspaceId: Bitrise workspace ID this project is associated with (local connections only)
    ///   - authToken: Auth token (local connections only)
    /// - Returns: A Bitrise instance.
    public static func bitrise(url: String, workspaceId: String, authToken: String) -> Bitrise {
        Bitrise(url: url, workspaceId: workspaceId, authToken: authToken)
    }
}
