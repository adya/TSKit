// - Since: 11/28/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

public extension Set {
    
    /// Creates a new `Set` with given `element` inserted into it.
    ///
    /// This method silently inserts the `element` using default `insert` method,
    /// but ignoring its result.
    func inserting(_ element: Element) -> Self {
        TSKit_Core.transform(self) { $0.insert(element) }
    }
}
