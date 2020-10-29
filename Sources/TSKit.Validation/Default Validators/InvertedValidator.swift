// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

public class InvertedValidator : AnyValidator {
    
    enum Errors : Error {
        case inverted(Error)
    }
    
    private let validator: AnyValidator
    
    public var errors: [Error] {
        return validator.errors.map { Errors.inverted($0) }
    }
    
    public init(validator : AnyValidator) {
        self.validator = validator
    }
    
    public func canValidate(_ value: Any?) -> Bool {
        return validator.canValidate(value)
    }
    
    public func validate(_ value: Any?) -> Bool {
        return !validator.validate(value)
    }
}

public prefix func !(validator : AnyValidator) -> AnyValidator {
    return InvertedValidator(validator : validator)
}
