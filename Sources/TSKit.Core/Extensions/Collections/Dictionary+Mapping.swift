// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Dictionary {
    
    /// Creates a new `Dictionary` by transforming each existing key-value pair using `transform` closure.
    /// - Parameter transform: Closure which applies transformation to key-value pairs.
    ///                        `transform` closure returns a transformed `(key, value)` tuple.
    ///                        In case of either `key`, `value` or tuple is `nil` transformation fails
    ///                        and current key-value pair will be skipped.
    /// - Returns: A new `dictionary` containing successfully transformed key-value pairs.
    func compactMap<NewKeyType, NewValueType>(_ transform: (Iterator.Element) throws -> (NewKeyType?, NewValueType?)?)
    rethrows -> [NewKeyType: NewValueType] {
        var dict = [NewKeyType: NewValueType]()
        for pair in self {
            if let transformed = try transform(pair),
               let key = transformed.0,
               let value = transformed.1 {
                dict[key] = value
            }
        }
        return dict
    }
}
