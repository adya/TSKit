// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

public extension AnyLogger {
    
    /// Logs to debug level.
    /// `Debug` messages are used to log any details required
    /// to determine possible causes of known issues while debugging application.
    ///
    /// Logger inspects `tag` objects and finds the best representation of it:
    /// - When passing `String` it will be used directly
    /// - When passing `CustomStringConvertible` its `description` property will be used,
    /// - When passing a `Type` object its name will be used
    /// - Any other objects will be represented as its type and treated as `Type`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional objects used to categorize current log message to certain groups.
    func debug(_ message: String?,
               tag: Any?...,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) {
        self.debug(message, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    /// Logs to verbose level.
    /// `Verbose` messages are typically used to describe
    /// operation's non-primary details while it's running.
    ///
    /// Logger inspects `tag` objects and finds the best representation of it:
    /// - When passing `String` it will be used directly
    /// - When passing `CustomStringConvertible` its `description` property will be used,
    /// - When passing a `Type` object its name will be used
    /// - Any other objects will be represented as its type and treated as `Type`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional objects used to categorize current log message to certain groups.
    func verbose(_ message: String?,
                 tag: Any?...,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) {
        self.verbose(message, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    /// Logs to info level.
    /// `Info` messages are used to provide some useful information
    /// about any operation results, completion.
    ///
    /// Logger inspects `tag` objects and finds the best representation of it:
    /// - When passing `String` it will be used directly
    /// - When passing `CustomStringConvertible` its `description` property will be used,
    /// - When passing a `Type` object its name will be used
    /// - Any other objects will be represented as its type and treated as `Type`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional objects used to categorize current log message to certain groups.
    func info(_ message: String?,
              tag: Any?...,
        functionName: String = #function,
        fileName: String = #file,
        lineNumber: Int = #line) {
        self.info(message, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    /// Logs to warning level.
    /// `Warning` message indicates that some non-critical issue occurred
    /// which doesn't stop/block any operations but still needs attention.
    /// - Note: `warning` can be used to mark some unfinished functionality.
    ///
    /// Logger inspects `tag` objects and finds the best representation of it:
    /// - When passing `String` it will be used directly
    /// - When passing `CustomStringConvertible` its `description` property will be used,
    /// - When passing a `Type` object its name will be used
    /// - Any other objects will be represented as its type and treated as `Type`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional objects used to categorize current log message to certain groups.
    func warning(_ message: String?,
                 tag: Any?...,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) {
        self.warning(message, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    /// Logs to error level.
    /// `Error` message indicates that some expected and handled error occurred
    /// which leads in cancellation of the operation where this error occurred.
    ///
    /// Logger inspects `tag` objects and finds the best representation of it:
    /// - When passing `String` it will be used directly
    /// - When passing `CustomStringConvertible` its `description` property will be used,
    /// - When passing a `Type` object its name will be used
    /// - Any other objects will be represented as its type and treated as `Type`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional objects used to categorize current log message to certain groups.
    func error(_ message: String?,
               tag: Any?...,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) {
        self.error(message, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
    /// Logs to severe level.
    /// `Severe` message indicates that some critical error occurred
    /// which leads to undefined behavior and/or crash.
    ///
    /// Logger inspects `tag` objects and finds the best representation of it:
    /// - When passing `String` it will be used directly
    /// - When passing `CustomStringConvertible` its `description` property will be used,
    /// - When passing a `Type` object its name will be used
    /// - Any other objects will be represented as its type and treated as `Type`.
    /// - Parameter message: Expression representing a message.
    /// - Parameter tag: Optional objects used to categorize current log message to certain groups.
    func severe(_ message: String?,
                tag: Any?...,
                functionName: String = #function,
                fileName: String = #file,
                lineNumber: Int = #line) {
        self.severe(message, tag: tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
    
}
