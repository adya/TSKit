// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation

public extension DispatchQueue {
    
    /// Performs provided `execute` closure on the `main` queue synchronuosly.
    ///
    /// When called from any background `DispatchQueue` this method will dispatch
    /// given `execute` closure synchrounously to `DisaptchQueue.main`,
    /// otherwise `execute` closure will be immediately called on the `main` thread.
    func syncIfNeeded<Result>(_ execute: () -> Result) -> Result {
        if self == DispatchQueue.main && Thread.isMainThread {
            return execute()
        } else {
            return self.sync(execute: execute)
        }
    }
}
