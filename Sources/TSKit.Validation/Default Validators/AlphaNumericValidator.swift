// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

import Foundation

/// Validates alphanumeric characters only.
public class AlphaNumericValidator: PatternValidator {

    public enum ValidationError: String, Error {

        case mismatchNumbers = "String contains non alpha-numeric characters"

        public var description: String {
            return rawValue
        }
    }

    public init() {
        super.init(pattern: "\\w+",
                   error: ValidationError.mismatchNumbers)
    }
}
