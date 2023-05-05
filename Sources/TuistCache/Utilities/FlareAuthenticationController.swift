import Foundation
import TuistGraph
import TuistSupport

public protocol BitriseAuthenticationControlling {
    func effectiveBitriseConfig(_ bitriseConfig: Bitrise?) -> Bitrise?
}

public final class BitriseAuthenticationController: BitriseAuthenticationControlling {
    private let environmentVariables: () -> [String: String]

    public init(
        environmentVariables: @escaping () -> [String: String] = { ProcessInfo.processInfo.environment }
    ) {
        self.environmentVariables = environmentVariables
    }

    public func effectiveBitriseConfig(_ bitriseConfig: Bitrise?) -> Bitrise? {
        let environment = environmentVariables()
        let urlFromEnvironment = environment[envKeyUrl]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let tokenFromEnvironment = environment[envKeyToken]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if !urlFromEnvironment.isEmpty, !tokenFromEnvironment.isEmpty {
            return Bitrise(url: urlFromEnvironment, workspaceId: "", authToken: tokenFromEnvironment)
        } else if (bitriseConfig?.url ?? "").isEmpty, (bitriseConfig?.authToken ?? "").isEmpty {
            logger
                .warning(
                    "No Bitrise remote cache configured via env vars nor in Config.swift. Continuing without remote cache..."
                )
            return nil
        } else {
            return bitriseConfig
        }
    }
}

private let envKeyUrl = "REMOTE_CACHE_ENDPOINT"
private let envKeyToken = "REMOTE_CACHE_TOKEN"
