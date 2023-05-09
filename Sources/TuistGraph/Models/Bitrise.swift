import Foundation

/// A Bitrise configuration, used for remote caching without a Tuist Cloud instance.
public struct Bitrise: Equatable, Hashable {
    /// The base URL that points to the server
    public let url: String

    /// Bitrise workspace ID this project is associated with (local connections only)
    /// This should be only defined if `authToken` is a Bitrise PAT
    public let workspaceId: String

    /// The auth token (either a JWT token or a Bitrise PAT)
    public let authToken: String

    /// Returns a Bitrise configuration.
    ///   - url: Base URL to the Cloud server.
    ///   - workspaceId: Bitrise workspace ID this project is associated with (local connections only)
    ///   - authToken: Auth token (local connections only)
    /// - Returns: A Bitrise instance.
    public init(url: String, workspaceId: String, authToken: String) {
        self.url = url
        self.workspaceId = workspaceId
        self.authToken = authToken
    }
}
