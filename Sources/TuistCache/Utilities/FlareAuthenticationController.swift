import Foundation
import TuistGraph
import TuistSupport

public protocol FlareAuthenticationControlling {
    func effectiveFlareConfig(_ flareConfig: Flare?) -> Flare?
}

public final class FlareAuthenticationController: FlareAuthenticationControlling {
    private let environmentVariables: () -> [String: String]

    public init(
        environmentVariables: @escaping () -> [String: String] = { ProcessInfo.processInfo.environment }
    ) {
        self.environmentVariables = environmentVariables
    }

    public func effectiveFlareConfig(_ flareConfig: Flare?) -> Flare? {
        let environment = environmentVariables()
        let urlFromEnvironment = environment[envKeyUrl]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let tokenFromEnvironment = environment[envKeyToken]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if !urlFromEnvironment.isEmpty, !tokenFromEnvironment.isEmpty {
            return Flare(url: urlFromEnvironment, authToken: tokenFromEnvironment)
        } else if (flareConfig?.url ?? "").isEmpty, (flareConfig?.authToken ?? "").isEmpty {
            logger
                .warning(
                    "No Bitrise remote cache configured via env vars nor in Config.swift. Continuing without remote cache..."
                )
            return nil
        } else {
            return flareConfig
        }
    }
}

private let envKeyUrl = "REMOTE_CACHE_ENDPOINT"
private let envKeyToken = "REMOTE_CACHE_TOKEN"
