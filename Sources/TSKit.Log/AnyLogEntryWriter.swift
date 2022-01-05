// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

/// Object that writes log output.
public protocol AnyLogEntryWriter: class {

    var interceptors: [AnyLogInterceptor] { get set }

    var decorator: AnyLogEntryDecorator { get set }

    func write(_ logEntry: LogEntry)
}
