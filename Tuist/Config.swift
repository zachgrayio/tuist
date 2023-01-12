import ProjectDescription

let config = Config(
    // currently we don't attempt to connect to a Flare/Bazel API instance if cloud is present at all, so this is
    // commented out here for now until this is changed in the future, if ever.
    // cloud: .cloud(
    //     projectId: "tuist/tuist",
    //     url: "https://cloud.tuist.io",
    //     options: [.optional, .analytics]
    // ),
    flare: .flare(
        url: cacheUrl(),
        authToken: authToken()
    ),
    swiftVersion: .init("5.4.0")
)

func cacheUrl() -> String {
    if case let .string(bitriseCacheUrl) = Environment.bitriseCacheUrl {
        return bitriseCacheUrl
    } else {
        return "gprc://localhost:6666"
    }
}

func authToken() -> String {
    if case let .string(bitriseCacheToken) = Environment.bitriseCacheToken {
        return bitriseCacheToken
    } else {
        return "local_bitrise"
    }
}
