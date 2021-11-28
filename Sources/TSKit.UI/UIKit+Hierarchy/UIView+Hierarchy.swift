// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.UI/blob/master/LICENSE.md
#if os(iOS)
import UIKit

public extension UIView {

    /// Iterates through all views of specified type in the hierarchy of target `UIView` and performs `updates` on each applicable `UIView`.
    /// - Parameter controller: Type of the controller to be found.
    /// - Parameter updates: A closure that will be called for all controllers of given type.
    @available(*, deprecated, message: "Use filter(where:) to get the list of desired views")
    func forEach<T>(view: T.Type, _ updates: @escaping (T) -> Void) where T: UIView {
        func process(_ view: UIView) {
            if let desiredView = view as? T {
                updates(desiredView)
            }
            view.subviews.forEach(process)
        }

        process(self)
    }

    /// Returns first subview of specified type in the hierarchy.
    /// Finds the first subview of specified type in the hierarchy of target `UIView`.
    ///
    /// For example, the following code will find the first instance of `UIButton` in hierarchy of given `view`:
    /// ```
    /// let button = view.first(UIButton.self)
    /// ```
    /// - Parameter controller: Type of the view to be found.
    func first<View>(_ viewType: View.Type) -> View? where View: UIView {
        func traverse(_ view: UIView) -> View? {
            if let desiredView = view as? View {
                return desiredView
            }

            for subview in view.subviews {
                if let desiredView = traverse(subview) {
                    return desiredView
                }
            }

            return nil
        }

        return traverse(self)
    }
}
#endif
