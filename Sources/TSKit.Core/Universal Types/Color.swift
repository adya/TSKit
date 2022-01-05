// - Since: 12/12/2021
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2022. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

#if os(iOS)
import UIKit
public typealias Color = UIColor
#elseif os(macOS)
import AppKit
public typealias Color = NSColor
#endif
