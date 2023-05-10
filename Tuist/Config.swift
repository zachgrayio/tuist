import ProjectDescription

let config = Config(
    // currently we don't attempt to connect to a Flare/Bazel API instance if cloud is present at all, so this is
    // commented out here for now until this is changed in the future, if ever.
    // cloud: .cloud(
    //     projectId: "tuist/tuist",
    //     url: "https://cloud.tuist.io",
    //     options: [.optional, .analytics]
    // ),

    // Enable remote cache here or via the following env vars:
    // - REMOTE_CACHE_ENDPOINT
    // - REMOTE_CACHE_TOKEN

    // bitrise: .bitrise(
    //     workspaceId: Environment.bitriseWorkspaceId.getString(default: ""),
    //     authToken: Environment.bitriseAuthToken.getString(default: "")
    // ),

    swiftVersion: .init("5.6.0")
)
