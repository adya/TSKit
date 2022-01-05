// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

public class LogLevelLogInterceptor: AnyLogInterceptor {

    public var ignoredLevels: Set<LogLevel>

    public init(ignoredLevels: LogLevel...) {
        self.ignoredLevels = Set(ignoredLevels)
    }

    public func shouldLog(_ entry: LogEntry) -> Bool {
        return !ignoredLevels.contains(entry.level)
    }
}
