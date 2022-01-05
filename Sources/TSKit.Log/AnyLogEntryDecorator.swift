// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

/// Decorates log entry before its being sent to output.
public protocol AnyLogEntryDecorator: AnyObject {

    func decorate(_ entry: LogEntry) -> String
}
