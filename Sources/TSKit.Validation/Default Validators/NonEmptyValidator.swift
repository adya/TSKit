// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

/// Requires value to be not empty.
/// - Parameter String: Validates non empty `String`.
/// - Parameter Array: Validates non empty `Array`.
/// - Parameter Set: Validates non empty `Set`.
/// - Parameter Dictionary: Validates non empty `Dictionary`.
/// - Parameter Countable: Any type which conforms to `Countable` protocol.
public class NonEmptyValidator: AnyValidator {

    public enum ValidationError: String, Error {

        /// Value is `nil`.
        case empty = "Value is empty"

        public var description: String {
            return rawValue
        }
    }

    public var errors: [Error] = []

    public func canValidate(_ value: Any?) -> Bool {
        return value is Countable
    }

    public func validate(_ value: Any?) -> Bool {
        guard let value = value as? Countable else {
            return true
        }
        return value.count > 0
    }

    public init() {}

}
