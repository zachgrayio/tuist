#!/bin/sh

set -e

PATH=$PATH:./tools

rm -rf Sources/BazelProto
mkdir Sources/BazelProto

# todo: proper linux support

# generate swift code for Bazel remote APIs and build event protocol and their dependencies
./tools/bin/protodep up -f --use-https

./tools/bin/protoc \
   proto/kv_storage/*.proto \
   managed_proto/google/devtools/build/v1/*.proto \
   managed_proto/google/longrunning/*.proto \
   managed_proto/google/rpc/*.proto \
   managed_proto/google/bytestream/*.proto \
   managed_proto/build_event_stream/*.proto \
   managed_proto/src/main/protobuf/*.proto \
   managed_proto/build/bazel/remote/execution/v2/*.proto \
   managed_proto/build/bazel/semver/*.proto \
   -I=managed_proto/ \
   -I=proto/ \
   --swift_out=Sources/BazelProto/ \
   --swift_opt=Visibility=Public \
   --grpc-swift_opt=Visibility=Public \
   --grpc-swift_out=Sources/BazelProto/

rm -f Sources/BazelProto/src/main/protobuf/remote_execution_log.pb.swift
