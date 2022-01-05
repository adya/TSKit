// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

import Foundation
import TSKit_Core

open class LogEntryDecorator: AnyLogEntryDecorator {
    
    /// Representation style of a log level in decorated message.
    public var style: LogLevelStyle
    
    /// An array of tags that are present in decorated message.
    /// Tags are presented in the same order they positioned in the array.
    public var tags: [Tag]
    
    /// Formatter used to format timestamp tag in decorated message.
    public var dateFormatter: DateFormatter
    
    public convenience init(style: LogLevelStyle = .iconic,
                            tags: [Tag] = Tag.allCases) {
        self.init(style: style, dateFormatter: .default, tags: tags)
    }
    
    public required init(style: LogLevelStyle = .iconic,
                         dateFormatter: DateFormatter,
                         tags: [Tag] = Tag.allCases) {
        self.style = style
        self.dateFormatter = dateFormatter
        self.tags = tags
    }

    open func decorate(_ entry: LogEntry) -> String {
        let date = dateFormatter.string(from: entry.timestamp)
        let customTags = entry.tags.map { "\($0)" }
        
        let prefix = tags.flatMap { (tag: Tag) -> [String] in
            switch tag {
            case .level: return [self.logLevel(entry.level, with: style)]
            case .timestamp: return [date]
            case .file: return [(entry.fileName as NSString).lastPathComponent]
            case .line: return ["\(entry.lineNumber)"]
            case .method: return [entry.functionName]
            case .custom: return customTags
            }
        }.map { "[\($0)]" }
         .joined(separator: " ")
        
        return "\(prefix) : \(entry.message)"
    }
    
    private func logLevel(_ level: LogLevel, with style: LogLevelStyle) -> String {
        switch style {
        case .iconic: return level.icon
        case .textual: return level.text
        case .mixed: return level.verbose
        }
    }
}

private extension DateFormatter {
    
    static var `default`: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss.SSS"
        return formatter
    }
}

public extension LogEntryDecorator {
    
    enum Tag: CaseIterable {
        
        case timestamp
        
        case level
        
        case file
        
        case line
        
        case method
        
        case custom
        
    }
    
}

public enum LogLevelStyle {
    case iconic
    case textual
    case mixed
}


public extension LogLevel  {

    var verbose: String {
        return "\(icon)️ \(text)"
    }

    var icon: String {
        switch self {
        case .debug: return "⚙️"
        case .verbose: return "📝"
        case .info: return "ℹ️"
        case .warning: return "⚠️"
        case .error: return "‼️️"
        case .severe: return "🆘"
        }
    }
    
    var text: String {
        switch self {
        case .debug: return "DEBUG"
        case .verbose: return "VERBOSE"
        case .info: return "INFO"
        case .warning: return "WARNING"
        case .error: return "ERROR"
        case .severe: return "SEVERE"
        }
    }
}
