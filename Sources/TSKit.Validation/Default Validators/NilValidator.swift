// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

import Foundation

/// Requires value to be not `nil`.
/// - Parameter Any: Accepts any values.
public class NilValidator : AnyValidator {
    
    public enum ValidationError: String, Error {
        
        /// Value is `nil`.
        case empty = "Value is nil"
        
        public var description: String {
            return rawValue
        }
    }
    
    public init() {}
    
    public let errors: [Error] = [ValidationError.empty]
    
    public func canValidate(_ value: Any?) -> Bool {
        return true
    }
    
    public func validate(_ value: Any?) -> Bool {
        return value != nil
    }
}
