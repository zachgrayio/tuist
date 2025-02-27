// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: src/main/protobuf/test_status.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Copyright 2014 The Bazel Authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

/// Status data of test cases which failed (used only for printing test summary)
public enum Blaze_FailedTestCasesStatus: SwiftProtobuf.Enum {
  public typealias RawValue = Int

  ///* Information about every test case is available. 
  case full // = 1

  ///* Information about some test cases may be missing. 
  case partial // = 2

  ///* No information about individual test cases. 
  case notAvailable // = 3

  ///* This is an empty object still without data. 
  case empty // = 4

  public init() {
    self = .full
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 1: self = .full
    case 2: self = .partial
    case 3: self = .notAvailable
    case 4: self = .empty
    default: return nil
    }
  }

  public var rawValue: Int {
    switch self {
    case .full: return 1
    case .partial: return 2
    case .notAvailable: return 3
    case .empty: return 4
    }
  }

}

#if swift(>=4.2)

extension Blaze_FailedTestCasesStatus: CaseIterable {
  // Support synthesized by the compiler.
}

#endif  // swift(>=4.2)

/// Detailed status data for a TestRunnerAction execution.
public enum Blaze_BlazeTestStatus: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case noStatus // = 0
  case passed // = 1
  case flaky // = 2
  case timeout // = 3
  case failed // = 4
  case incomplete // = 5
  case remoteFailure // = 6
  case failedToBuild // = 7
  case blazeHaltedBeforeTesting // = 8

  public init() {
    self = .noStatus
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .noStatus
    case 1: self = .passed
    case 2: self = .flaky
    case 3: self = .timeout
    case 4: self = .failed
    case 5: self = .incomplete
    case 6: self = .remoteFailure
    case 7: self = .failedToBuild
    case 8: self = .blazeHaltedBeforeTesting
    default: return nil
    }
  }

  public var rawValue: Int {
    switch self {
    case .noStatus: return 0
    case .passed: return 1
    case .flaky: return 2
    case .timeout: return 3
    case .failed: return 4
    case .incomplete: return 5
    case .remoteFailure: return 6
    case .failedToBuild: return 7
    case .blazeHaltedBeforeTesting: return 8
    }
  }

}

#if swift(>=4.2)

extension Blaze_BlazeTestStatus: CaseIterable {
  // Support synthesized by the compiler.
}

#endif  // swift(>=4.2)

/// TestCase contains detailed data about all tests (cases/suites/decorators)
/// ran, structured in a tree. This data will be later used to present the tests
/// by the web status server.
public struct Blaze_TestCase {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var child: [Blaze_TestCase] = []

  public var name: String {
    get {return _name ?? String()}
    set {_name = newValue}
  }
  /// Returns true if `name` has been explicitly set.
  public var hasName: Bool {return self._name != nil}
  /// Clears the value of `name`. Subsequent reads from it will return its default value.
  public mutating func clearName() {self._name = nil}

  public var className: String {
    get {return _className ?? String()}
    set {_className = newValue}
  }
  /// Returns true if `className` has been explicitly set.
  public var hasClassName: Bool {return self._className != nil}
  /// Clears the value of `className`. Subsequent reads from it will return its default value.
  public mutating func clearClassName() {self._className = nil}

  public var runDurationMillis: Int64 {
    get {return _runDurationMillis ?? 0}
    set {_runDurationMillis = newValue}
  }
  /// Returns true if `runDurationMillis` has been explicitly set.
  public var hasRunDurationMillis: Bool {return self._runDurationMillis != nil}
  /// Clears the value of `runDurationMillis`. Subsequent reads from it will return its default value.
  public mutating func clearRunDurationMillis() {self._runDurationMillis = nil}

  public var result: String {
    get {return _result ?? String()}
    set {_result = newValue}
  }
  /// Returns true if `result` has been explicitly set.
  public var hasResult: Bool {return self._result != nil}
  /// Clears the value of `result`. Subsequent reads from it will return its default value.
  public mutating func clearResult() {self._result = nil}

  public var type: Blaze_TestCase.TypeEnum {
    get {return _type ?? .testCase}
    set {_type = newValue}
  }
  /// Returns true if `type` has been explicitly set.
  public var hasType: Bool {return self._type != nil}
  /// Clears the value of `type`. Subsequent reads from it will return its default value.
  public mutating func clearType() {self._type = nil}

  public var status: Blaze_TestCase.Status {
    get {return _status ?? .passed}
    set {_status = newValue}
  }
  /// Returns true if `status` has been explicitly set.
  public var hasStatus: Bool {return self._status != nil}
  /// Clears the value of `status`. Subsequent reads from it will return its default value.
  public mutating func clearStatus() {self._status = nil}

  public var run: Bool {
    get {return _run ?? true}
    set {_run = newValue}
  }
  /// Returns true if `run` has been explicitly set.
  public var hasRun: Bool {return self._run != nil}
  /// Clears the value of `run`. Subsequent reads from it will return its default value.
  public mutating func clearRun() {self._run = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public enum TypeEnum: SwiftProtobuf.Enum {
    public typealias RawValue = Int
    case testCase // = 0
    case testSuite // = 1
    case testDecorator // = 2
    case unknown // = 3

    public init() {
      self = .testCase
    }

    public init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .testCase
      case 1: self = .testSuite
      case 2: self = .testDecorator
      case 3: self = .unknown
      default: return nil
      }
    }

    public var rawValue: Int {
      switch self {
      case .testCase: return 0
      case .testSuite: return 1
      case .testDecorator: return 2
      case .unknown: return 3
      }
    }

  }

  public enum Status: SwiftProtobuf.Enum {
    public typealias RawValue = Int
    case passed // = 0
    case failed // = 1
    case error // = 2

    public init() {
      self = .passed
    }

    public init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .passed
      case 1: self = .failed
      case 2: self = .error
      default: return nil
      }
    }

    public var rawValue: Int {
      switch self {
      case .passed: return 0
      case .failed: return 1
      case .error: return 2
      }
    }

  }

  public init() {}

  fileprivate var _name: String? = nil
  fileprivate var _className: String? = nil
  fileprivate var _runDurationMillis: Int64? = nil
  fileprivate var _result: String? = nil
  fileprivate var _type: Blaze_TestCase.TypeEnum? = nil
  fileprivate var _status: Blaze_TestCase.Status? = nil
  fileprivate var _run: Bool? = nil
}

#if swift(>=4.2)

extension Blaze_TestCase.TypeEnum: CaseIterable {
  // Support synthesized by the compiler.
}

extension Blaze_TestCase.Status: CaseIterable {
  // Support synthesized by the compiler.
}

#endif  // swift(>=4.2)

/// TestResultData holds the outcome data for a single test action (A
/// single test rule can result in multiple actions due to sharding and
/// runs_per_test settings.)
public struct Blaze_TestResultData {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// The following two fields are used for TestRunnerAction caching.
  /// This reflects the fact that failing tests are successful
  /// actions that might be cached, depending on option settings.
  public var cachable: Bool {
    get {return _storage._cachable ?? false}
    set {_uniqueStorage()._cachable = newValue}
  }
  /// Returns true if `cachable` has been explicitly set.
  public var hasCachable: Bool {return _storage._cachable != nil}
  /// Clears the value of `cachable`. Subsequent reads from it will return its default value.
  public mutating func clearCachable() {_uniqueStorage()._cachable = nil}

  public var testPassed: Bool {
    get {return _storage._testPassed ?? false}
    set {_uniqueStorage()._testPassed = newValue}
  }
  /// Returns true if `testPassed` has been explicitly set.
  public var hasTestPassed: Bool {return _storage._testPassed != nil}
  /// Clears the value of `testPassed`. Subsequent reads from it will return its default value.
  public mutating func clearTestPassed() {_uniqueStorage()._testPassed = nil}

  /// Following data is informational.
  public var status: Blaze_BlazeTestStatus {
    get {return _storage._status ?? .noStatus}
    set {_uniqueStorage()._status = newValue}
  }
  /// Returns true if `status` has been explicitly set.
  public var hasStatus: Bool {return _storage._status != nil}
  /// Clears the value of `status`. Subsequent reads from it will return its default value.
  public mutating func clearStatus() {_uniqueStorage()._status = nil}

  public var statusDetails: String {
    get {return _storage._statusDetails ?? String()}
    set {_uniqueStorage()._statusDetails = newValue}
  }
  /// Returns true if `statusDetails` has been explicitly set.
  public var hasStatusDetails: Bool {return _storage._statusDetails != nil}
  /// Clears the value of `statusDetails`. Subsequent reads from it will return its default value.
  public mutating func clearStatusDetails() {_uniqueStorage()._statusDetails = nil}

  public var failedLogs: [String] {
    get {return _storage._failedLogs}
    set {_uniqueStorage()._failedLogs = newValue}
  }

  public var warning: [String] {
    get {return _storage._warning}
    set {_uniqueStorage()._warning = newValue}
  }

  public var hasCoverage_p: Bool {
    get {return _storage._hasCoverage_p ?? false}
    set {_uniqueStorage()._hasCoverage_p = newValue}
  }
  /// Returns true if `hasCoverage_p` has been explicitly set.
  public var hasHasCoverage_p: Bool {return _storage._hasCoverage_p != nil}
  /// Clears the value of `hasCoverage_p`. Subsequent reads from it will return its default value.
  public mutating func clearHasCoverage_p() {_uniqueStorage()._hasCoverage_p = nil}

  /// Returns if this was cached in remote execution.
  public var remotelyCached: Bool {
    get {return _storage._remotelyCached ?? false}
    set {_uniqueStorage()._remotelyCached = newValue}
  }
  /// Returns true if `remotelyCached` has been explicitly set.
  public var hasRemotelyCached: Bool {return _storage._remotelyCached != nil}
  /// Clears the value of `remotelyCached`. Subsequent reads from it will return its default value.
  public mutating func clearRemotelyCached() {_uniqueStorage()._remotelyCached = nil}

  /// Returns true if this was executed remotely
  public var isRemoteStrategy: Bool {
    get {return _storage._isRemoteStrategy ?? false}
    set {_uniqueStorage()._isRemoteStrategy = newValue}
  }
  /// Returns true if `isRemoteStrategy` has been explicitly set.
  public var hasIsRemoteStrategy: Bool {return _storage._isRemoteStrategy != nil}
  /// Clears the value of `isRemoteStrategy`. Subsequent reads from it will return its default value.
  public mutating func clearIsRemoteStrategy() {_uniqueStorage()._isRemoteStrategy = nil}

  /// All associated test times (in ms).
  public var testTimes: [Int64] {
    get {return _storage._testTimes}
    set {_uniqueStorage()._testTimes = newValue}
  }

  /// Passed log paths. Set if the test passed.
  public var passedLog: String {
    get {return _storage._passedLog ?? String()}
    set {_uniqueStorage()._passedLog = newValue}
  }
  /// Returns true if `passedLog` has been explicitly set.
  public var hasPassedLog: Bool {return _storage._passedLog != nil}
  /// Clears the value of `passedLog`. Subsequent reads from it will return its default value.
  public mutating func clearPassedLog() {_uniqueStorage()._passedLog = nil}

  /// Test times, without remote execution overhead (in ms).
  public var testProcessTimes: [Int64] {
    get {return _storage._testProcessTimes}
    set {_uniqueStorage()._testProcessTimes = newValue}
  }

  /// Total time in ms.
  public var runDurationMillis: Int64 {
    get {return _storage._runDurationMillis ?? 0}
    set {_uniqueStorage()._runDurationMillis = newValue}
  }
  /// Returns true if `runDurationMillis` has been explicitly set.
  public var hasRunDurationMillis: Bool {return _storage._runDurationMillis != nil}
  /// Clears the value of `runDurationMillis`. Subsequent reads from it will return its default value.
  public mutating func clearRunDurationMillis() {_uniqueStorage()._runDurationMillis = nil}

  /// Start time of the test action in ms since the epoch.
  public var startTimeMillisEpoch: Int64 {
    get {return _storage._startTimeMillisEpoch ?? 0}
    set {_uniqueStorage()._startTimeMillisEpoch = newValue}
  }
  /// Returns true if `startTimeMillisEpoch` has been explicitly set.
  public var hasStartTimeMillisEpoch: Bool {return _storage._startTimeMillisEpoch != nil}
  /// Clears the value of `startTimeMillisEpoch`. Subsequent reads from it will return its default value.
  public mutating func clearStartTimeMillisEpoch() {_uniqueStorage()._startTimeMillisEpoch = nil}

  /// Additional build info
  public var testCase: Blaze_TestCase {
    get {return _storage._testCase ?? Blaze_TestCase()}
    set {_uniqueStorage()._testCase = newValue}
  }
  /// Returns true if `testCase` has been explicitly set.
  public var hasTestCase: Bool {return _storage._testCase != nil}
  /// Clears the value of `testCase`. Subsequent reads from it will return its default value.
  public mutating func clearTestCase() {_uniqueStorage()._testCase = nil}

  public var failedStatus: Blaze_FailedTestCasesStatus {
    get {return _storage._failedStatus ?? .full}
    set {_uniqueStorage()._failedStatus = newValue}
  }
  /// Returns true if `failedStatus` has been explicitly set.
  public var hasFailedStatus: Bool {return _storage._failedStatus != nil}
  /// Clears the value of `failedStatus`. Subsequent reads from it will return its default value.
  public mutating func clearFailedStatus() {_uniqueStorage()._failedStatus = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Blaze_FailedTestCasesStatus: @unchecked Sendable {}
extension Blaze_BlazeTestStatus: @unchecked Sendable {}
extension Blaze_TestCase: @unchecked Sendable {}
extension Blaze_TestCase.TypeEnum: @unchecked Sendable {}
extension Blaze_TestCase.Status: @unchecked Sendable {}
extension Blaze_TestResultData: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "blaze"

extension Blaze_FailedTestCasesStatus: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "FULL"),
    2: .same(proto: "PARTIAL"),
    3: .same(proto: "NOT_AVAILABLE"),
    4: .same(proto: "EMPTY"),
  ]
}

extension Blaze_BlazeTestStatus: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "NO_STATUS"),
    1: .same(proto: "PASSED"),
    2: .same(proto: "FLAKY"),
    3: .same(proto: "TIMEOUT"),
    4: .same(proto: "FAILED"),
    5: .same(proto: "INCOMPLETE"),
    6: .same(proto: "REMOTE_FAILURE"),
    7: .same(proto: "FAILED_TO_BUILD"),
    8: .same(proto: "BLAZE_HALTED_BEFORE_TESTING"),
  ]
}

extension Blaze_TestCase: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TestCase"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "child"),
    2: .same(proto: "name"),
    3: .standard(proto: "class_name"),
    4: .standard(proto: "run_duration_millis"),
    5: .same(proto: "result"),
    6: .same(proto: "type"),
    7: .same(proto: "status"),
    8: .same(proto: "run"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.child) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self._name) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self._className) }()
      case 4: try { try decoder.decodeSingularInt64Field(value: &self._runDurationMillis) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self._result) }()
      case 6: try { try decoder.decodeSingularEnumField(value: &self._type) }()
      case 7: try { try decoder.decodeSingularEnumField(value: &self._status) }()
      case 8: try { try decoder.decodeSingularBoolField(value: &self._run) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.child.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.child, fieldNumber: 1)
    }
    try { if let v = self._name {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._className {
      try visitor.visitSingularStringField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._runDurationMillis {
      try visitor.visitSingularInt64Field(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._result {
      try visitor.visitSingularStringField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._type {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._status {
      try visitor.visitSingularEnumField(value: v, fieldNumber: 7)
    } }()
    try { if let v = self._run {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 8)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Blaze_TestCase, rhs: Blaze_TestCase) -> Bool {
    if lhs.child != rhs.child {return false}
    if lhs._name != rhs._name {return false}
    if lhs._className != rhs._className {return false}
    if lhs._runDurationMillis != rhs._runDurationMillis {return false}
    if lhs._result != rhs._result {return false}
    if lhs._type != rhs._type {return false}
    if lhs._status != rhs._status {return false}
    if lhs._run != rhs._run {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Blaze_TestCase.TypeEnum: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "TEST_CASE"),
    1: .same(proto: "TEST_SUITE"),
    2: .same(proto: "TEST_DECORATOR"),
    3: .same(proto: "UNKNOWN"),
  ]
}

extension Blaze_TestCase.Status: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "PASSED"),
    1: .same(proto: "FAILED"),
    2: .same(proto: "ERROR"),
  ]
}

extension Blaze_TestResultData: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".TestResultData"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "cachable"),
    2: .standard(proto: "test_passed"),
    3: .same(proto: "status"),
    16: .standard(proto: "status_details"),
    4: .standard(proto: "failed_logs"),
    5: .same(proto: "warning"),
    6: .standard(proto: "has_coverage"),
    7: .standard(proto: "remotely_cached"),
    8: .standard(proto: "is_remote_strategy"),
    9: .standard(proto: "test_times"),
    10: .standard(proto: "passed_log"),
    11: .standard(proto: "test_process_times"),
    12: .standard(proto: "run_duration_millis"),
    15: .standard(proto: "start_time_millis_epoch"),
    13: .standard(proto: "test_case"),
    14: .standard(proto: "failed_status"),
  ]

  fileprivate class _StorageClass {
    var _cachable: Bool? = nil
    var _testPassed: Bool? = nil
    var _status: Blaze_BlazeTestStatus? = nil
    var _statusDetails: String? = nil
    var _failedLogs: [String] = []
    var _warning: [String] = []
    var _hasCoverage_p: Bool? = nil
    var _remotelyCached: Bool? = nil
    var _isRemoteStrategy: Bool? = nil
    var _testTimes: [Int64] = []
    var _passedLog: String? = nil
    var _testProcessTimes: [Int64] = []
    var _runDurationMillis: Int64? = nil
    var _startTimeMillisEpoch: Int64? = nil
    var _testCase: Blaze_TestCase? = nil
    var _failedStatus: Blaze_FailedTestCasesStatus? = nil

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _cachable = source._cachable
      _testPassed = source._testPassed
      _status = source._status
      _statusDetails = source._statusDetails
      _failedLogs = source._failedLogs
      _warning = source._warning
      _hasCoverage_p = source._hasCoverage_p
      _remotelyCached = source._remotelyCached
      _isRemoteStrategy = source._isRemoteStrategy
      _testTimes = source._testTimes
      _passedLog = source._passedLog
      _testProcessTimes = source._testProcessTimes
      _runDurationMillis = source._runDurationMillis
      _startTimeMillisEpoch = source._startTimeMillisEpoch
      _testCase = source._testCase
      _failedStatus = source._failedStatus
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularBoolField(value: &_storage._cachable) }()
        case 2: try { try decoder.decodeSingularBoolField(value: &_storage._testPassed) }()
        case 3: try { try decoder.decodeSingularEnumField(value: &_storage._status) }()
        case 4: try { try decoder.decodeRepeatedStringField(value: &_storage._failedLogs) }()
        case 5: try { try decoder.decodeRepeatedStringField(value: &_storage._warning) }()
        case 6: try { try decoder.decodeSingularBoolField(value: &_storage._hasCoverage_p) }()
        case 7: try { try decoder.decodeSingularBoolField(value: &_storage._remotelyCached) }()
        case 8: try { try decoder.decodeSingularBoolField(value: &_storage._isRemoteStrategy) }()
        case 9: try { try decoder.decodeRepeatedInt64Field(value: &_storage._testTimes) }()
        case 10: try { try decoder.decodeSingularStringField(value: &_storage._passedLog) }()
        case 11: try { try decoder.decodeRepeatedInt64Field(value: &_storage._testProcessTimes) }()
        case 12: try { try decoder.decodeSingularInt64Field(value: &_storage._runDurationMillis) }()
        case 13: try { try decoder.decodeSingularMessageField(value: &_storage._testCase) }()
        case 14: try { try decoder.decodeSingularEnumField(value: &_storage._failedStatus) }()
        case 15: try { try decoder.decodeSingularInt64Field(value: &_storage._startTimeMillisEpoch) }()
        case 16: try { try decoder.decodeSingularStringField(value: &_storage._statusDetails) }()
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      try { if let v = _storage._cachable {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 1)
      } }()
      try { if let v = _storage._testPassed {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 2)
      } }()
      try { if let v = _storage._status {
        try visitor.visitSingularEnumField(value: v, fieldNumber: 3)
      } }()
      if !_storage._failedLogs.isEmpty {
        try visitor.visitRepeatedStringField(value: _storage._failedLogs, fieldNumber: 4)
      }
      if !_storage._warning.isEmpty {
        try visitor.visitRepeatedStringField(value: _storage._warning, fieldNumber: 5)
      }
      try { if let v = _storage._hasCoverage_p {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 6)
      } }()
      try { if let v = _storage._remotelyCached {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 7)
      } }()
      try { if let v = _storage._isRemoteStrategy {
        try visitor.visitSingularBoolField(value: v, fieldNumber: 8)
      } }()
      if !_storage._testTimes.isEmpty {
        try visitor.visitRepeatedInt64Field(value: _storage._testTimes, fieldNumber: 9)
      }
      try { if let v = _storage._passedLog {
        try visitor.visitSingularStringField(value: v, fieldNumber: 10)
      } }()
      if !_storage._testProcessTimes.isEmpty {
        try visitor.visitRepeatedInt64Field(value: _storage._testProcessTimes, fieldNumber: 11)
      }
      try { if let v = _storage._runDurationMillis {
        try visitor.visitSingularInt64Field(value: v, fieldNumber: 12)
      } }()
      try { if let v = _storage._testCase {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 13)
      } }()
      try { if let v = _storage._failedStatus {
        try visitor.visitSingularEnumField(value: v, fieldNumber: 14)
      } }()
      try { if let v = _storage._startTimeMillisEpoch {
        try visitor.visitSingularInt64Field(value: v, fieldNumber: 15)
      } }()
      try { if let v = _storage._statusDetails {
        try visitor.visitSingularStringField(value: v, fieldNumber: 16)
      } }()
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Blaze_TestResultData, rhs: Blaze_TestResultData) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._cachable != rhs_storage._cachable {return false}
        if _storage._testPassed != rhs_storage._testPassed {return false}
        if _storage._status != rhs_storage._status {return false}
        if _storage._statusDetails != rhs_storage._statusDetails {return false}
        if _storage._failedLogs != rhs_storage._failedLogs {return false}
        if _storage._warning != rhs_storage._warning {return false}
        if _storage._hasCoverage_p != rhs_storage._hasCoverage_p {return false}
        if _storage._remotelyCached != rhs_storage._remotelyCached {return false}
        if _storage._isRemoteStrategy != rhs_storage._isRemoteStrategy {return false}
        if _storage._testTimes != rhs_storage._testTimes {return false}
        if _storage._passedLog != rhs_storage._passedLog {return false}
        if _storage._testProcessTimes != rhs_storage._testProcessTimes {return false}
        if _storage._runDurationMillis != rhs_storage._runDurationMillis {return false}
        if _storage._startTimeMillisEpoch != rhs_storage._startTimeMillisEpoch {return false}
        if _storage._testCase != rhs_storage._testCase {return false}
        if _storage._failedStatus != rhs_storage._failedStatus {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
