// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

import TSKit_Core

public class PrintLogEntryWriter: AnyLogEntryWriter {

    public var interceptors: [AnyLogInterceptor]

    public var decorator: AnyLogEntryDecorator

    public init(decorator: AnyLogEntryDecorator = LogEntryDecorator(),
                interceptors: AnyLogInterceptor...) {
        self.decorator = decorator
        self.interceptors = interceptors
    }

    public func write(_ entry: LogEntry) {
        decorator.decorate(entry) ==> { print($0) }
    }
}
