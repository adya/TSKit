// - Since: 09/29/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.UI/blob/master/LICENSE.md
#if os(iOS)
import UIKit

// MARK: - filter
public extension UIViewController {
    
    /// Filters controllers in the hierarchy of target controller using given `predicate`.
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    /// - Seealso: `flattenControllers`.
    func filter(where predicate: ControllerPredicate) -> [UIViewController] {
        flattenControllers().filter(predicate)
    }
    
    /// Filters controllers of specified type in the hierarchy of target controller.
    /// - Parameter controller: Type of the controller to be found.
    /// - Seealso: `flattenControllers`.
    func filter<Controller>(_ controller: Controller.Type) -> [Controller] {
        flattenControllers().compactMap { $0 as? Controller }
    }
    
}

// MARK: - forEach
public extension UIViewController {
        
    /// Iterates through all controllers in the hierarchy of target controller that satisfies given `predicate` and performs `updates` on each applicable controller.
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    /// - Parameter updates: A closure that will be called for all controllers matching `predicate`.
    @available(*, deprecated, message: "Use filter(where:) to get the list of desired controllers")
    func forEach(where predicate: ControllerPredicate,
                 updates: (UIViewController) -> Void) {
        filter(where: predicate).forEach(updates)
    }
    
    /// Iterates through all controllers of specified type in the hierarchy of target controller and performs `updates` on each applicable controller.
    /// - Parameter controller: Type of the controller to be found.
    /// - Parameter updates: A closure that will be called for all controllers of given type.
    @available(*, deprecated, message: "Use filter(controller:) to get the list of desired controllers")
    func forEach<Controller>(_ controller: Controller.Type,
                             updates: (Controller) -> Void) {
        filter(controller).forEach(updates)
    }
}

// MARK: - first
public extension UIViewController {
    
    /// Finds the first controller in the hierarchy of target controller that satisfies the given `predicate`.
    ///
    /// For example, the following code will find the first controller with  "Settings" title in a hierarchy of given `controller`:
    /// ```
    /// let settingsController = controller.first(where: { $0.title = "Settings" })
    /// ```
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    /// - Seealso: `flattenControllers`.
    func first(where predicate: ControllerPredicate) -> UIViewController? {
        flattenControllers().first(where: predicate)
    }
    
    /// Finds the first controller of specified type in the hierarchy of target controller.
    ///
    /// For example, the following code will find the first instance of `UINavigationController` in hierarchy of given `controller`:
    /// ```
    /// let navController = controller.first(UINavigationController.self)
    /// ```
    /// - Parameter controller: Type of the controller to be found.
    /// - Seealso: `flattenControllers`.
    func first<Controller>(_ controller: Controller.Type) -> Controller? {
        flattenControllers().first(where: { $0 is Controller }) as? Controller
    }
}

// MARK: - last
public extension UIViewController {

    
    /// Finds the last controller in the hierarchy that satisfies the given `predicate`.
    ///
    /// For example, the following code will find the last controller with  "Settings" title in a hierarchy of given `controller`:
    /// ```
    /// let settingsController = controller.last(where: { $0.title = "Settings" })
    /// ```
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    /// - Seealso: `flattenControllers`.
    func last(where predicate: ControllerPredicate) -> UIViewController? {
        flattenControllers().last(where: predicate)
    }
    
    /// Finds the first controller of specified type in the hierarchy of target controller.
    ///
    /// For example, the following code will find the last instance of `UINavigationController` in hierarchy of given `controller`:
    /// ```
    /// let navController = controller.last(UINavigationController.self)
    /// ```
    /// - Parameter controller: Type of the controller to be found.
    /// - Seealso: `flattenControllers`.
    func last<Controller>(_ controller: Controller.Type) -> Controller? {
        flattenControllers().last(where: { $0 is Controller }) as? Controller
    }
}

// MARK: - Flattening
public extension UIViewController {
    
    typealias ControllerPredicate = (UIViewController) -> Bool
    
    /// Flatten controllers hierarchy into a one-dimensional array.
    ///
    /// This method traverses the hierarchy from the top using depth-first search.
    /// It prioritizes controllers in the following order:
    /// - Target controller (self)
    /// - `presentedViewController`
    /// - `UINavigationController`'s nested controllers
    /// - `UITabBarController`'s nested controllers
    /// - `UISplitViewController`'s nested controllers
    /// - Target controller's children controllers
    func flattenControllers() -> [UIViewController] {
        func traverse(_ controller: UIViewController) -> [UIViewController] {
            var list: [UIViewController] = []
            list.append(controller)
            if let presented = controller.presentedViewController {
                list += traverse(presented)
            }
            if let navController = controller as? UINavigationController {
                list += navController.viewControllers.flatMap(traverse)
            } else if let tabController = controller as? UITabBarController {
                list += tabController.viewControllers?.flatMap(traverse) ?? []
            } else if let splitController = controller as? UISplitViewController {
                list += splitController.viewControllers.flatMap(traverse)
            } else {
                list += controller.children.flatMap(traverse)
            }
            return list
        }
        
        return traverse(self)
    }
}
#endif
