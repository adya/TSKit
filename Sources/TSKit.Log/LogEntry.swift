// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

import Foundation

public struct LogEntry {
    
    public var message: String

    public var timestamp: Date

    public var tags: [String]

    public var level: LogLevel

    public var functionName: String

    public var fileName: String

    public var lineNumber: Int
    
    public init(message: String,
                timestamp: Date,
                tags: [String],
                level: LogLevel,
                functionName: String = #function,
                fileName: String = #file,
                lineNumber: Int = #line) {
        self.message = message
        self.timestamp = timestamp
        self.tags = tags
        self.level = level
        self.functionName = functionName
        self.fileName = fileName
        self.lineNumber = lineNumber
    }
}
