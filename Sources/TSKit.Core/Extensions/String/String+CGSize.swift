// - Since: 01/20/2018
// - Author: Arkadii Hlushchevskyi
// - Copyright: © 2020. Arkadii Hlushchevskyi.
// - Seealso: https://github.com/adya/TSKit.Core/blob/master/LICENSE.md

import Foundation
#if os(iOS)
import CoreGraphics
#endif

public extension String {
    
    /// Calculates size of string's bounding rectangle using specified `font` and constrained width and height.
    /// - Parameter font: Desired `UIFont` of the string to be bounded.
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    /// - Returns: Size of the bounding rectangle which fits content of the string.
    @available(macOS 10.11, *)
    func size(with font: Font, constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude, constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let maxSize = CGSize(width: maxWidth, height: maxHeight)
        let attributes: [NSAttributedString.Key : Any] = [.font : font]
        
        return self.boundingRect(with: maxSize,
                                 options: [.usesFontLeading, .usesLineFragmentOrigin],
                                 attributes: attributes,
                                 context: nil).size
    }
    
    /// Calculates height of string's bounding rectangle using specified `font` and constrained width.
    /// - Parameter font: Desired `UIFont` of the string to be bounded.
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Returns: Height of the bounding rectangle which fits content of the string.
    @available(macOS 10.11, *)
    func height(with font: Font, constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        size(with: font, constrainingWidth: maxWidth).height
    }
    
    /// Calculates width of string's bounding rectangle using specified `font` and constrained height.
    /// - Parameter font: Desired `UIFont` of the string to be bounded.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    @available(macOS 10.11, *)
    func width(with font: Font, constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        size(with: font, constrainingHeight: maxHeight).width
    }
}

// MARK: - String size.
extension NSAttributedString {
    
    /// Calculates size of string's bounding rectangle using specified `font` and constrained width and height.ß
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    /// - Returns: Size of the bounding rectangle which fits content of the string.
    @available(macOS 10.11, *)
    func size(constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude, constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGSize {
        let maxSize = CGSize(width: maxWidth, height: maxHeight)
        
        return self.boundingRect(with: maxSize,
                                 options: [.usesFontLeading, .usesLineFragmentOrigin],
                                 context: nil).size
    }
    
    /// Calculates height of string's bounding rectangle using specified `font` and constrained width.
    /// - Parameter maxWidth: Desired maximum width of the bounding rectangle.
    /// - Returns: Height of the bounding rectangle which fits content of the string.
    @available(macOS 10.11, *)
    func height(constrainingWidth maxWidth: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        size(constrainingWidth: maxWidth).height
    }
    
    /// Calculates width of string's bounding rectangle using specified `font` and constrained height.
    /// - Parameter maxHeight: Desired maximum height of the bounding rectangle.
    /// - Returns: Width of the bounding rectangle which fits content of the string.
    @available(macOS 10.11, *)
    func width(constrainingHeight maxHeight: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        size(constrainingHeight: maxHeight).width
    }
}
