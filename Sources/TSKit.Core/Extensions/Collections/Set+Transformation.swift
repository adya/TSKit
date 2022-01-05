// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Set {

    /// Performs `transformation` on elements of the collection using `inout` closure.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    /// - Seealso: `transform`.
    mutating func transform(_ transformation: (inout Element) -> Void) {
        self = transformed(transformation)
    }

    /// Performs `transformation` on elements of the collection using `inout` closure.
    ///
    /// This method is similar to `map`, but it operates with the elements of the same type,
    /// making clear the intention of the transformation.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    /// - Seealso: `transform`.
    func transformed(_ transformation: (inout Element) -> Void) -> Self {
        Set(map { TSKit_Core.transform($0, transformation) })
    }
}
