// - Since: 04/20/2020
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension String {
    
    /// - Returns: Randomized alphanumeric string with specified `count`.
    static func random(count: UInt) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<count).map{ _ in letters.randomElement()! })
    }
}
