// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

public class CompoundValidator : AnyValidator {
   
    private let conjunction : ValidationConjunction
    
    private let validators : [AnyValidator]
    
    public var errors: [Error] {
        return validators.flatMap { $0.errors }
    }
    
    public init(validators : [AnyValidator], conjunction : ValidationConjunction = .all) {
        self.conjunction = conjunction
        self.validators = validators
    }
    
    public func canValidate(_ value: Any?) -> Bool {
        return !validators.isEmpty
    }
    
    public func validate(_ value: Any?) -> Bool {
        guard validators.count > 0 else {
            return true
        }
        let passed = validators.filter{$0.validate(value)}
        switch conjunction {
        case .all: return validators.count == passed.count
        case .any: return passed.count > 0
        case .none: return passed.count == 0
        }
    }
}

/// Defines how `CompoundValidator` should treat specified set of `Validators`.
public enum ValidationConjunction {
    
    /// Valid if all provided validators are valid.
    case all
    
    /// Valid if at least one of provided validators is valid.
    case any
    
    /// Valid if all provided validators are not valid.
    case none
}

// MARK: .All
public func & (v1 : AnyValidator, v2 : AnyValidator) -> AnyValidator {
    return CompoundValidator(validators: [v1, v2], conjunction: .all)
}

public func & (v1 : [AnyValidator], v2 : [AnyValidator]) -> AnyValidator {
    return CompoundValidator(validators: v1 + v2, conjunction: .all)
}

public func & (v1 : [AnyValidator], v2 : AnyValidator) -> AnyValidator {
    return v1 & [v2]
}

public func & (v1 : AnyValidator, v2 : [AnyValidator]) -> AnyValidator {
    return [v1] & v2
}

// MARK: .Any
public func | (v1 : AnyValidator, v2 : AnyValidator) -> AnyValidator {
    return CompoundValidator(validators: [v1, v2], conjunction: .any)
}

public func | (v1 : [AnyValidator], v2 : [AnyValidator]) -> AnyValidator {
    return CompoundValidator(validators: v1 + v2, conjunction: .any)
}

public func | (v1 : [AnyValidator], v2 : AnyValidator) -> AnyValidator {
    return v1 | [v2]
}

public func | (v1 : AnyValidator, v2 : [AnyValidator]) -> AnyValidator {
    return [v1] | v2
}

// MARK: .None
public func ^ (v1 : AnyValidator, v2 : AnyValidator) -> AnyValidator {
    return CompoundValidator(validators: [v1, v2], conjunction: .none)
}

public func ^ (v1 : [AnyValidator], v2 : [AnyValidator]) -> AnyValidator {
    return CompoundValidator(validators: v1 + v2, conjunction: .none)
}

public func ^ (v1 : [AnyValidator], v2 : AnyValidator) -> AnyValidator {
    return v1 ^ [v2]
}

public func ^ (v1 : AnyValidator, v2 : [AnyValidator]) -> AnyValidator {
    return [v1] ^ v2
}

