// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md
import Foundation

public struct LogEntry {

    public let message: String

    public let timestamp: Date

    public let tags: [String]

    public let level: LogLevel

    public let functionName: String

    public let fileName: String

    public let lineNumber: Int
}
