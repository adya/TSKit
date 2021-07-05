// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Log/blob/master/LICENSE.md

public protocol AnyLogInterceptor: AnyObject {

    func shouldLog(_ entry: LogEntry) -> Bool
}
