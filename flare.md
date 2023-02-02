# Flare/Bazel remote api integration
## Overview

This fork allows a Bazel remote cache backend to power a Tuist build, and without reliance on a deployment of the Tuist Cloud web API.

We must use gRPC for these connections, as such, tooling to manage protos and generate Swift from said protos is included. Generated sources are checked in, meaning few contributors should be impacted by the codegen tooling. 

Also present are the definitions necessary to send build event data to a Bazel Build Event Stream compliant server (not yet implemented).

### Design notes

The first iteration focuses on decoupling remote caching from the Cloud APIs; we do this by adding an additional `CacheRemoteStorage` implementation which connects to a Remote APIs backend directly. An alternative approach might have been to simply store the bytestream-compliant Resource Name in a record in the Cloud backend, and simply extend the original `CacheRemoteStorage` impl to use the gRPC client if the resource URL wasn't a full https:// url; however, since the initial goal is to avoid any reliance on a Tuist Cloud backend entirely, this wasn't done.

Furthermore, the gRPC building blocks are present here to also send whatever relevant metrics to a Bazel Build Event Protocol backend rather than Tuist Cloud, but that work can and will be done separately.

## Prerequisites

- `brew install swift-protobuf grpc-swift`
- note the `tools` dir contains some binaries, furthermore note they are for macOS; ideally this should be managed better

## Running Code Generation

(not necessary for most contributors)

- Ensure prereq's are installed
- Run `./gen_proto.sh`
- to add deps, edit `protodep.toml`

