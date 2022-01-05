// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

import Foundation

/// Validates an email.
public class EmailValidator : PatternValidator {
    
    public enum ValidationError: String, LocalizedError {
        
        case mismatchEmail = "Not a valid email"
        
        public var description: String {
            return rawValue
        }
    }
    
    public init() {
        super.init(pattern: "([A-Z0-9a-z._%+-]+)@(?:([A-Za-z0-9-]+)\\.)+([A-Za-z]{2,6})",
                   error: ValidationError.mismatchEmail)
    }
}
