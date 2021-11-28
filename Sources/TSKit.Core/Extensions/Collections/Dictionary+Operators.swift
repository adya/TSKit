// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

/// Appends all keys and values from the `right` dictionary to the `left`.
///
/// Combines two dictionaries. Elements with the same key will be overwritten by the `right` dictionaory.
public func += <K, V>(_ left: inout [K: V], _ right: [K: V]) {
    right.forEach { (k, v) in left[k] = v } 
}

/// Creates a new dictionary containing all keys and values from both `left` and `right` dictionaries.
///
/// Combines two dictionaries. Elements with the same key will be overwritten by the `right` dictionaory.
public func + <K, V>(_ left: [K: V], _ right: [K: V]) -> [K: V] {
    transform(left) { $0 += right }
}

/// Removes all keys and values of the `right` dictionary from the `left` dictionary.
public func -= <K, V>(_ left: inout [K: V], _ right: [K: V]) {
    right.keys.forEach { left[$0] = nil }
}

/// Removes all keys and values of the `right` dictionary from the `left` dictionary.
public func - <K, V>(_ left: [K: V], _ right: [K: V]) -> [K: V] {
    transform(left) { $0 -= right }
}
