// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

/// - Parameter String: Validates `String`'s length.
/// - Parameter Array: Validates `Array`'s size.
/// - Parameter Set: Validates `Set`'s size.
/// - Parameter Dictionary: Validates `Dictionary`'s size.
/// - Parameter Countable: Validates count of any `Countable`.
public class LengthValidator : ValueValidator<Int> {
    
    override class var defaultValueName: String {
        return "length"
    }
    
    public init(minimumLength: Int, maximumLength: Int) {
        super.init(lowerBound: .inclusive(minimumLength),
                   upperBound: .inclusive(maximumLength))
    }
    
    public init(minimumLength: Int) {
        super.init(lowerBound: .inclusive(minimumLength))
    }
    
    public init(maximumLength: Int) {
        super.init(upperBound: .inclusive(maximumLength))
    }
    
    public override func canValidate(_ value: Any?) -> Bool {
        return value is Countable
    }
    
    public override func validate(_ value: Any?) -> Bool {
        guard let countable = value as? Countable else {
            return true
        }
        return super.validate(countable.count)
    }
}
