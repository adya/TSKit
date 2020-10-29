import XCTest
@testable import TSKit_Log

class DecoratorTests: XCTestCase {
    
    var decorator: LogEntryDecorator!
    
    private let message = "test"
    
    private let timestamp = Date()
    
    private var entry: LogEntry!
    
    override func setUp() {
        super.setUp()
        decorator = LogEntryDecorator(style: .textual,
                                             dateFormatter: .testable)
        entry = LogEntry(message: "test",
                         timestamp: timestamp,
                         tags: ["custom"],
                         level: .debug,
                         functionName: "Test",
                         fileName: "DecoratorTests",
                         lineNumber: 1)
    }
    
    
    func testDefaultSetup() {
        let res = decorator.decorate(entry)
        let date = DateFormatter.testable.string(from: timestamp)
        XCTAssert(res == "[\(date)] [\(entry.level.text)] [\(entry.fileName)] [\(entry.lineNumber)] [\(entry.functionName)] [\(entry.tags.first!)] : \(entry.message)")
    }
    
    func testFileOnlyTag() {
        decorator.tags = [.file]
        let res = decorator.decorate(entry)
        XCTAssert(res == "[\(entry.fileName)] : \(entry.message)")
    }
    
    func testLineOnlyTag() {
        decorator.tags = [.line]
        let res = decorator.decorate(entry)
        XCTAssert(res == "[\(entry.lineNumber)] : \(entry.message)")
    }
    
    func testMethodOnlyTag() {
        decorator.tags = [.method]
        let res = decorator.decorate(entry)
        XCTAssert(res == "[\(entry.functionName)] : \(entry.message)")
    }
    
    func testTimestampOnlyTag() {
        decorator.tags = [.timestamp]
        let res = decorator.decorate(entry)
        let date = DateFormatter.testable.string(from: timestamp)
        XCTAssert(res == "[\(date)] : \(entry.message)")
    }
    
    func testCustomTagsOnly() {
        decorator.tags = [.custom]
        let res = decorator.decorate(entry)
        XCTAssert(res == "[\(entry.tags.first!)] : \(entry.message)")
    }
}

private extension DateFormatter {
    
    static var testable: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }
}
