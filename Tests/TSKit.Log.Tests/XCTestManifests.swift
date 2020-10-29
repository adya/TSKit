import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TSKit_LogTests.allTests),
    ]
}
#endif
