// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence {
    
    /// Groups any sequence by the hashable key specified in the closure
    /// and creates a dictionary containing arrays for each unique key.
    ///
    /// This method is mostly obsoleted by `group(by:)` alternative based on `KeyPath`.
    /// The only meaningful usage of closure-based method is when the `key` is either optional
    /// or there is some logic for `key` that might return `nil` for elements that should be ignored.
    /// - Important: Elements for which `key` evaluates to `nil` will be ignored and not included in the resulting dictionary.
    /// - Note: `key` must conform to `Hashable` protocol.
    /// - Parameter key: A closure that provides a key property of `Sequence` elements to group by.
    /// - Returns: A dictionary containing arrays of elements for each unique key.
    func group<KeyType: Hashable>(by key: (Iterator.Element) -> KeyType?) -> [KeyType: [Iterator.Element]] {
        reduce(into: [:]) {
            if let key = key($1) {
                $0[key] = ($0[key] ?? []).appending($1)
            }
        }
    }
    
    /// Groups any sequence by the hashable key specified by given `keyPath`
    /// and creates a dictionary containing arrays for each unique key.
    ///
    /// - Note: `keyPath` must point  to the property that conforms to `Hashable` protocol.
    /// - Parameter keyPath: A *KeyPath* of the property of `Sequence` elements to group by.
    /// - Returns: A dictionary containing arrays of elements for each unique key.
    func group<KeyType: Hashable>(by keyPath: KeyPath<Element, KeyType>) -> [KeyType: [Iterator.Element]] {
        reduce(into: [:]) {
            let key = $1[keyPath: keyPath]
            $0[key] = ($0[key] ?? []).appending($1)
        }
    }
}
