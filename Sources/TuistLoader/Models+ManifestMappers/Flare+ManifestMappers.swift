import Foundation
import ProjectDescription
import TSCBasic
import TuistCore
import TuistGraph
import TuistSupport

extension TuistGraph.Bitrise {
    static func from(manifest: ProjectDescription.Bitrise) throws -> TuistGraph.Bitrise {
        TuistGraph.Bitrise(url: manifest.url, workspaceId: manifest.workspaceId, authToken: manifest.authToken)
    }
}
