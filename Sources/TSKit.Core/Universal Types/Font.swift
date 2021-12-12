// - Since: 12/12/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

#if os(iOS)
import UIKit
public typealias Font = UIFont
#elseif os(macOS)
import AppKit
public typealias Font = NSFont
#endif
