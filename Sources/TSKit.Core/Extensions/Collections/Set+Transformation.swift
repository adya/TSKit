// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Set {

    /// Performs `transformation` on elements of the collection using `inout` closure.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    mutating func transform(_ transformation: (inout Element) -> Void) {
        self = transformed(transformation)
    }

    /// Performs `transformation` on elements of the collection using `inout` closure.
    ///
    /// This method is similar to `map`, but it operates with the elements of the same type,
    /// making intentions
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    func transformed(_ transformation: (inout Element) -> Void) -> Self {
        Set(map { TSKit_Core.transform($0, transformation) })
    }
}