// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Sequence {
    
    /// Returns a pair of arrays containing, in order, the elements of the sequence that satisfy the given predicate.
    ///
    /// Splits the elements of the sequence into two arrays with elements that satisfy the given predicate and not.
    /// - Parameter isIncluded: A closure that takes an element of the sequence as its argument
    ///                         and returns a Boolean value indicating whether the element
    ///                         should be included in the first returned array or second.
    /// - Returns: A pair of arrays where first array contains elements allowed by `isIncluded` and second array contains those elements which are not allowed.
    func filtered(_ isIncluded: (Element) throws -> Bool) rethrows -> ([Element], [Element]) {
        try reduce(([], [])) { result, element in
            return try isIncluded(element)
                ? (result.0 + [element], result.1)
                : (result.0, result.1 + [element])
        }
    }
}

public extension Sequence where Element: Hashable {
    
    /// Returns a pair of sets containing the elements of sequence that satisfy the given predicate.
    ///
    /// Splits the elements of sequence into two sets with elements that satisfy the given predicate and not.
    /// - Parameter isIncluded: A closure that takes an element of the set as its argument
    ///                         and returns a Boolean value indicating whether the element
    ///                         should be included in the first returned set or second.
    /// - Returns: A pair of sets where first set contains elements allowed by `isIncluded` and second set contains those elements which are not allowed.
    func filteredSet(_ isIncluded: (Element) throws -> Bool) rethrows -> (Set<Element>, Set<Element>) {
        try reduce(([], [])) { result, element in
             try isIncluded(element)
                ? (result.0.inserting(element), result.1)
                : (result.0, result.1.inserting(element))
        }
    }
}
