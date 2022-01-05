// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

/// - Parameter Comparable: Validates any `Comparable` values.
public class ValueValidator<ValueType: Comparable>: AnyValidator {

    public enum ValidationError: Error {

        case lessThan(BoundRange)

        case greaterThan(BoundRange)

        case notEqual(ValueType)
    }


    /// Default name identyfing validatable `value`.
    class var defaultValueName: String {
        return "value"
    }

    /// Comparison bound of the value.
    public struct Bound: Comparable {

        /// Type of the `Bound`.
        public enum Kind {

            /// Value is not included in valid range.
            case exclusive

            /// Value is included in valid range.
            case inclusive

        }

        // This must be `Any` as a workaround for "cyclic metadata dependency" (see: https://bugs.swift.org/browse/SR-4383) occurring when `Bound` uses outter `ValueType` generic type.
        /// Boundary value.
        public let value: Any

        /// Type of the `Bound`
        public let kind: Bound.Kind

        static func inclusive(_ value: Any) -> Bound {
            return Bound(value: value, kind: .inclusive)
        }

        static func exclusive(_ value: Any) -> Bound {
            return Bound(value: value, kind: .exclusive)
        }
    }

    public typealias BoundRange = (Bound?, Bound?)

    private let lowerBound: Bound?

    private let upperBound: Bound?

    private var valueName: String = ""

    public var errors: [Error] = []

    public init(lowerBound: Bound, valueName: String? = nil) {
        self.lowerBound = lowerBound
        self.upperBound = nil
        self.valueName = valueName ?? type(of: self).defaultValueName
    }

    public init(upperBound: Bound, valueName: String? = nil) {
        self.lowerBound = nil
        self.upperBound = upperBound
        self.valueName = valueName ?? type(of: self).defaultValueName
    }

    public init(lowerBound: Bound, upperBound: Bound, valueName: String? = nil) {
        self.lowerBound = min(lowerBound, upperBound)
        self.upperBound = max(lowerBound, upperBound)
        self.valueName = valueName ?? type(of: self).defaultValueName
    }

    public init(exactValue: ValueType, valueName: String? = nil) {
        let bound = Bound.inclusive(exactValue)
        self.lowerBound = bound
        self.upperBound = bound
        self.valueName = valueName ?? type(of: self).defaultValueName
    }

    public convenience init(upperValue: ValueType, valueName: String? = nil) {
        self.init(upperBound: .inclusive(upperValue), valueName: valueName)
    }

    public convenience init(lowerValue: ValueType, valueName: String? = nil) {
        self.init(lowerBound: .inclusive(lowerValue), valueName: valueName)
    }

    public convenience init(lowerValue: ValueType,
                            upperValue: ValueType,
                            valueName: String? = nil) {
        self.init(lowerBound: .inclusive(lowerValue),
                  upperBound: .inclusive(upperValue),
                  valueName: valueName)
    }

    public convenience init(lowerBound: Bound,
                            upperValue: ValueType,
                            valueName: String? = nil) {
        self.init(lowerBound: lowerBound,
                  upperBound: .inclusive(upperValue),
                  valueName: valueName)
    }

    public convenience init(lowerValue: ValueType,
                            upperBound: Bound,
                            valueName: String? = nil) {
        self.init(lowerBound: .inclusive(lowerValue),
                  upperBound: upperBound,
                  valueName: valueName)
    }

    public func canValidate(_ value: Any?) -> Bool {
        return value is ValueType
    }

    public func validate(_ value: Any?) -> Bool {
        guard let valueT = value as? ValueType else {
            return true
        }
        let inLowerBound = self.lowerBound.flatMap {
            switch $0.kind {
            case .exclusive: return ($0.value as! ValueType) < valueT
            case .inclusive: return ($0.value as! ValueType) <= valueT
            }
        } ?? true
        let inUpperBound = self.upperBound.flatMap {
            switch $0.kind {
            case .exclusive: return valueT < ($0.value as! ValueType)
            case .inclusive: return valueT <= ($0.value as! ValueType)
            }
        } ?? true
        let isExactValue = (lowerBound?.value as? ValueType) == (upperBound?.value as? ValueType)
        if isExactValue {
            let isValid = inLowerBound && inUpperBound
            guard let value = lowerBound?.value else {
                return false
            }
            if !isValid {
                errors = [ValidationError.notEqual(value as! ValueType)]
            }
        } else {
            if !inLowerBound {
                errors = [ValidationError.lessThan((lowerBound, upperBound))]
            } else if !inUpperBound {
                errors = [ValidationError.greaterThan((lowerBound, upperBound))]
            }
        }
        return inLowerBound && inUpperBound
    }
}

public func <<ValueType>(_ x: ValueValidator<ValueType>.Bound, _ y: ValueValidator<ValueType>.Bound) -> Bool {
    return (x.value as! ValueType) < (y.value as! ValueType)
}

public func ==<ValueType>(_ x: ValueValidator<ValueType>.Bound, _ y: ValueValidator<ValueType>.Bound) -> Bool {
    return (x.value as! ValueType) == (y.value as! ValueType)
}
