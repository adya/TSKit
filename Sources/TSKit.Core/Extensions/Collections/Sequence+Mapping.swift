// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence {
    
    /// Maps `Sequence` to a `Dictionary` using `key` and `value` closures to build resulting `dictionary`.
    ///
    /// This method is mostly obsoleted by `map(key:value:)` alternative based on `KeyPath`.
    /// The only meaningful usage of closure-based method is when there is some logic for `key` or `value`
    /// that might throw an `Error` for elements that should be ignored.
    /// - Parameter key: A closure that provides a property of `Sequence`'s element to be used as a dictioanry key.
    /// - Parameter value: A closure that provides a property of `Sequence`'s element to be used as a dictioanry value.
    /// - Important: Elements for which either `key` or `value` throws an `Error` will be ignored and not included in the resulting dictionary.
    /// - Note: `key` must be unique in order to avoid collisions.
    ///         In cases when `key` may be not unique consider using `group(by:)` method to preserve all elements.
    /// - Returns: `Dictionary` containing key-value pairs.
    /// - Seealso: `compactMap(key:value:)`.
    func map<KeyType, ValueType>(key: (Iterator.Element) throws -> KeyType,
                                 value: (Iterator.Element) throws -> ValueType) -> [KeyType : ValueType] where KeyType : Hashable {
        reduce(into: [:]) {
            guard let key = try? key($1),
                  let value = try? value($1) else { return }
            $0[key] = value
        }
    }
    
    /// Maps `Sequence` to a `Dictionary` using `key` and `value` closures to build resulting `dictionary`.
    ///
    /// - Parameter key: A closure that provides a property of `Sequence`'s element to be used as a dictionary key.
    /// - Parameter value: A closure that provides a property of `Sequence`'s element to be used as a dictionary value.
    /// - Important: Elements for which either `key` or value evaluates to `nil` or throws an `Error` will be ignored and not included in the resulting dictionary.
    /// - Note: `key` must be unique in order to avoid collisions.
    ///         In cases when `key` may be not unique consider using `group(by:)` method to preserve all elements.
    /// - Returns: `Dictionary` containing key-value pairs.
    /// - Seealso: `map(key:value:)`.
    func compactMap<KeyType, ValueType>(key: (Iterator.Element) throws -> KeyType?,
                                        value: (Iterator.Element) throws -> ValueType?) -> [KeyType: ValueType] where KeyType : Hashable {
        reduce(into: [:]) {
            guard let key = try? key($1),
                  let value = try? value($1) else { return }
            $0[key] = value
        }
    }
    
    /// Maps `Sequence` to a `Dictionary` using `key` and `value` *KeyPath*s to build resulting `dictionary`.
    ///
    /// - Note: `key` must be unique in order to avoid collisions.
    ///         In cases when `key` may be not unique consider using `group(by:)` method to preserve all elements.
    /// - Note: You can use `\.self` notation of the *KeyPath* to reference the element itself.
    /// - Returns: `Dictionary` containing key-value pairs.
    /// - Seealso: `compactMap(key:value:)`.
    func map<KeyType, ValueType>(key: KeyPath<Element, KeyType>,
                                 value: KeyPath<Element, ValueType>) -> [KeyType : ValueType] where KeyType : Hashable {
        reduce(into: [:]) {
            let key = $1[keyPath: key]
            let value = $1[keyPath: value]
            $0[key] = value
        }
    }
    
}
