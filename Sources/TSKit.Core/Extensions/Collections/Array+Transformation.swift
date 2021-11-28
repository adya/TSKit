// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Array {

    /// Performs `transformation` on elements of the collection using `inout` closure.
    /// - Parameter transformation: `inout` closure that performs transformation of each element.
    mutating func transform(_ transformation: (inout Element) -> Void) {
        self = transformed(transformation)
    }

    func transformed(_ transformation: (inout Element) -> Void) -> Self {
        map {
            var item = $0
            transformation(&item)
            return item
        }
    }
}
