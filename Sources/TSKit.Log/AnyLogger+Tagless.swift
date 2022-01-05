// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

public extension AnyLogger {

    /// Logs to debug level.
    /// `Debug` messages are used to log any details required
    /// to determine possible causes of known issues while debugging application.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    func debug(_ message: String?,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) {
        self.debug(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    /// Logs to verbose level.
    /// `Verbose` messages are typically used to describe
    /// operation's non-primary details while it's running.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    func verbose(_ message: String?,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) {
        self.verbose(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    /// Logs to info level.
    /// `Info` messages are used to provide some useful information
    /// about any operation results, completion.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    func info(_ message: String?, functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        self.info(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    /// Logs to warning level.
    /// `Warning` message indicates that some non-critical issue occurred
    /// which doesn't stop/block any operations but still needs attention.
    /// - Note: `warning` can be used to mark some unfinished functionality.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    func warning(_ message: String?,
                 functionName: String = #function,
                 fileName: String = #file,
                 lineNumber: Int = #line) {
        self.warning(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    /// Logs to error level.
    /// `Error` message indicates that some expected and handled error occurred
    /// which leads in cancellation of the operation where this error occurred.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    func error(_ message: String?,
               functionName: String = #function,
               fileName: String = #file,
               lineNumber: Int = #line) {
        self.error(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

    /// Logs to severe level.
    /// `Severe` message indicates that some critical error occurred
    /// which leads to undefined behavior and/or crash.
    /// - Attention: Do not pass any parameters except `message`.
    /// - Parameter message: Expression representing a message.
    func severe(_ message: String?,
                functionName: String = #function,
                fileName: String = #file,
                lineNumber: Int = #line) {
        self.severe(message, tag: nil, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }

}
