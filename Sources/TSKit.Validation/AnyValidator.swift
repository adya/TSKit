// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

/*
 `AnyValidator` checks any passed value to meet validation rule of that validator.
 - Version: 2.0
 - Since: 10/31/2016
 - Date: 12/25/2017
 - Author: Arkadii Glushchevskyi
 */
public protocol AnyValidator {

    /// Checks whether or not given value can be validated by this validator.
    /// - Returns: `true` if `value` can be validated, otherwise `nil`.
    func canValidate(_ value: Any?) -> Bool

    /// Validates given value.
    /// - Important: Validator must return `true` for unsupported value types to indicate that they have nothing to do with this value.
    func validate(_ value: Any?) -> Bool

    /// Validation errors occurred after latest `validate()` call.
    var errors: [Error] { get }
}

// MARK: - Defaults

extension AnyValidator {
    /// Complementary method to be called by conforming types when received unsupported value types.
    @available(*, deprecated)
    func logUnsupportedType(_ value: Any?) {
        print("\(type(of: self)): Received value with unsupported type \(type(of: value)).")
    }

    @available(*, deprecated)
    func logEmpty() {
        print("\(type(of: self)): Received nil.")
    }
}
