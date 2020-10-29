// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

/// A type that has a countable sequence of elements.
public protocol Countable {

    /// Count of elements.
    var count: Int { get }
}

extension Array: Countable {}

extension Set: Countable {}

extension Dictionary: Countable {}

extension String: Countable {}
