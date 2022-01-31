// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Validation/blob/master/LICENSE.md

import Foundation

/// Validates an url.
public class UrlValidator : PatternValidator {
    
    public enum ValidationError: String, Error {
        
        case mismatchUrl = "Not a valid URL"
        
        public var description: String {
            return rawValue
        }
    }

    /// - Parameter allowSkippingScheme: Flag indicating whether scheme can be omitted in validating url.
    /// Passing `true` will make  url valid even without scheme, passing `false` will require url to have scheme.
    public init(allowSkippingScheme: Bool = false) {
        let schemePart = "(?:(http|https)://)\(allowSkippingScheme ? "?" : "")"
        let hostPart = "([a-zA-Z0-9_\\-])+"
        let pathPart = "(?:[\\.|/]([a-zA-Z0-9_\\-])+)+"
        let portPart = "(?::([0-9]+))?"
        super.init(pattern: "\(schemePart)\(hostPart)\(pathPart)\(portPart)",
                   error: ValidationError.mismatchUrl)
    }
}
