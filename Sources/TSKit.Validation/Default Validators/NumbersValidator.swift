// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

import Foundation

/// Validates number only.
public class NumbersValidator: PatternValidator {

    public enum ValidationError: String, Error {

        case mismatchNumbers = "String contains non-numeric characters"

        public var description: String {
            return rawValue
        }
    }

    public init() {
        super.init(pattern: "\\d+",
                   error: ValidationError.mismatchNumbers)
    }
}
