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

     bitrise: .bitrise(
         url: "grpcs://pluggable.services.bitrise.io",
         workspaceId: "bab000bcec3bd0c1",
         authToken: "RLparvsdxjhiB8Z7dl-NEHYt7aNNWhR7ieoHhYjGJW-vJ6-5oWZVU3N4njl06K-ONu17rrt0VaQlsG1ITy6zVw"
     ),


    // bitrise: .bitrise(url: "", workspaceId: "", authToken: ""),

    swiftVersion: .init("5.6.0")
)
