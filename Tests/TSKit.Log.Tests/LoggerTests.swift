import XCTest
@testable import TSKit_Log

class LoggerTests: XCTestCase {
    
    let writer = StringLogEntryWriter()
    
    let logger: AnyLogger = Logger()
    
    override func setUp() {
        super.setUp()
        let logger = self.logger as! Logger
        logger.writers.append(PrintLogEntryWriter())
        logger.writers.append(writer)
    }
    
    override func tearDown() {
        let logger = self.logger as! Logger
        logger.writers.removeAll()
        writer.output = ""
        super.tearDown()
    }
    
    func testTagless() {
        logger.debug("test", tag: nil)
        XCTAssert(writer.output == "test\n")
    }
    
    func testSingleStringTag() {
        logger.debug("test", tag: "TG")
        XCTAssert(writer.output == "[TG] test\n")
    }
    
    func testSingleObjectTag() {
        logger.debug("test", tag: writer)
        XCTAssert(writer.output == "[StringLogEntryWriter] test\n")
    }
    
    func testMultipleStringTags() {
        logger.debug("test", tag: "TG1", "TG2", "TG3")
        XCTAssert(writer.output == "[TG1][TG2][TG3] test\n")
    }
    
    func testMultipleMixedTags() {
        logger.debug("test", tag: "TG1", writer, "TG3")
        XCTAssert(writer.output == "[TG1][StringLogEntryWriter][TG3] test\n")
    }
    
    func testMultipleOptionalTags() {
        let tagNil: String? = nil
        let tagOptional: String? = "TG1"
        let tagValue = "TG3"
        let typeNil: StringLogEntryWriter.Type? = nil
        let typeOptional: StringLogEntryWriter.Type? = StringLogEntryWriter.self
        let typeValue = StringLogEntryWriter.self
        logger.debug("test", tag: tagNil, tagOptional, tagValue, typeNil, typeOptional, typeValue)
        XCTAssert(writer.output == "[TG1][TG3][StringLogEntryWriter][StringLogEntryWriter] test\n")
    }
    
    func testConvertibleEnumTag() {
        logger.debug("test", tag: ConvertibleTag.string)
        XCTAssert(writer.output == "[converted] test\n")
    }
    
    enum ConvertibleTag: CustomStringConvertible {
        case string
        
        var description: String {
            return "converted"
        }
    }

    class RawDecorator: LogEntryDecorator {
        
        override func decorate(_ entry: LogEntry) -> String {
            let tag = entry.tags.map { "[\($0)]" }.joined(separator: "")
            let tagFormatted = tag.isEmpty ? "" : "\(tag) "
            return "\(tagFormatted)\(entry.message)"
        }
    }
    
    class StringLogEntryWriter: AnyLogEntryWriter {
        
        var interceptors: [AnyLogInterceptor] = []
        
        var decorator: AnyLogEntryDecorator = RawDecorator()
        
        var output = ""
        
        func write(_ logEntry: LogEntry) {
            
            output += "\(decorator.decorate(logEntry))\n"
        }
    }
}
