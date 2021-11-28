// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2021. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.UI/blob/master/LICENSE.md
#if os(iOS)
import UIKit

// MARK: - filter
public extension UIWindow {
    
    /// Filters controllers in the hierarchy of `UIWindow`'s `rootViewController` using given `predicate`.
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    func filter(where predicate: UIViewController.ControllerPredicate) -> [UIViewController] {
        rootViewController?.filter(where: predicate) ?? []
    }
    
    /// Filters controllers of specified type in the hierarchy of `UIWindow`'s `rootViewController`.
    /// - Parameter controller: Type of the controller to be found.
    func filter<Controller>(controller: Controller.Type) -> [Controller] {
        rootViewController?.filter(controller) ?? []
    }
    
}

// MARK: - forEach
public extension UIWindow {
        
    /// Iterates through all controllers in the hierarchy of `UIWindow`'s `rootViewController` that satisfies given `predicate` and performs `updates` on each applicable controller.
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    /// - Parameter updates: A closure that will be called for all controllers matching `predicate`.
    @available(*, deprecated, message: "Use filter(where:) to get the list of desired controllers")
    func forEach(where predicate: UIViewController.ControllerPredicate,
                 updates: (UIViewController) -> Void) {
        rootViewController?.forEach(where: predicate, updates: updates)
    }
    
    /// Iterates through all controllers of specified type in the hierarchy of `UIWindow`'s `rootViewController` and performs `updates` on each applicable controller.
    /// - Parameter controller: Type of the controller to be found.
    /// - Parameter updates: A closure that will be called for all controllers of given type.
    @available(*, deprecated, message: "Use filter(controller:) to get the list of desired controllers")
    func forEach<Controller>(controller: Controller.Type,
                             updates: (Controller) -> Void) {
        rootViewController?.forEach(controller, updates: updates)
    }
}

// MARK: - first
public extension UIWindow {
    
    /// Finds the first controller in the hierarchy of `UIWindow`'s `rootViewController` that satisfies the given `predicate`.
    ///
    /// For example, the following code will find the first controller with  "Settings" title in a hierarchy of given `window`:
    /// ```
    /// let settingsController = window.first(where: { $0.title = "Settings" })
    /// ```
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    func first(where predicate: UIViewController.ControllerPredicate) -> UIViewController? {
        rootViewController?.first(where: predicate)
    }
    
    /// Finds the first controller of specified type in the hierarchy of `UIWindow`'s `rootViewController`.
    ///
    /// For example, the following code will find the first instance of `UINavigationController` in hierarchy of given `window`:
    /// ```
    /// let navController = window.first(controller: UINavigationController.self)
    /// ```
    /// - Parameter controller: Type of the controller to be found.
    func first<Controller>(controller: Controller.Type) -> Controller? {
        rootViewController?.first(where: { $0 is Controller }) as? Controller
    }
}

// MARK: - last
public extension UIWindow {

    /// Finds the last controller in the hierarchy of `UIWindow`'s `rootViewController` that satisfies the given `predicate`.
    ///
    /// For example, the following code will find the last controller with  "Settings" title in a hierarchy of given `window`:
    /// ```
    /// let settingsController = window.last(where: { $0.title = "Settings" })
    /// ```
    /// - Parameter predicate: A closure that takes a controller as its argument and returns a `Bool` value indicating whether the controller is a match.
    func last(where predicate: UIViewController.ControllerPredicate) -> UIViewController? {
        rootViewController?.last(where: predicate)
    }
    
    /// Finds the first controller of specified type in the hierarchy of `UIWindow`'s `rootViewController`.
    ///
    /// For example, the following code will find the last instance of `UINavigationController` in hierarchy of given `window`:
    /// ```
    /// let navController = window.last(controller: UINavigationController.self)
    /// ```
    /// - Parameter controller: Type of the controller to be found.
    func last<Controller>(controller: Controller.Type) -> Controller? {
        rootViewController?.last(where: { $0 is Controller }) as? Controller
    }
}
#endif
