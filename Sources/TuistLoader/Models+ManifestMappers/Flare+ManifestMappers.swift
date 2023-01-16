import Foundation
import ProjectDescription
import TSCBasic
import TuistCore
import TuistGraph
import TuistSupport

extension TuistGraph.Flare {
    static func from(manifest: ProjectDescription.Flare) throws -> TuistGraph.Flare {
        TuistGraph.Flare(url: manifest.url, authToken: manifest.authToken)
    }
}
