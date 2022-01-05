// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

import Foundation

/// Validates letters only.
public class LettersValidator : PatternValidator {
  
    public enum ValidationError: String, LocalizedError {
        
        case mismatchLetters = "String contains non-letter characters"
        
        public var description: String {
            return rawValue
        }
    }
    
    public init() {
        super.init(pattern: "[a-zA-Z]+",
                   error: ValidationError.mismatchLetters)
    }
}
