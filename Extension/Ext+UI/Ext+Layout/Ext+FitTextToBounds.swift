//
//  ResizeLabel.swift
//  ClockIn
//
//  Created by SuJustin on 2019/11/29.
//  Copyright © 2019 SuJustin. All rights reserved.
//  Swift5_iOS 13

import UIKit

extension UILabel{
    /// SwifterExt: Will auto resize the contained text to a font size which fits the frames bounds
    /// Uses the pre-set font to dynamicly determine the proper sizing
    func fitTextToBounds(){
        guard let text = text, let currentFont = font else { return }
//        print("[Resize \(text)] =========== \(currentFont.pointSize) ===========")
        if let dynamicFontSize = UIFont.bestFitFontSize(for: text, in: bounds, fontName: currentFont.fontName) {
            font = UIFont(name: currentFont.fontName, size: dynamicFontSize)
        }
    }
}

extension UIFont {
    /// SwifterExt: fit text To Bounds
    /// - Will return the best approximated font size which will fit in the bounds.
    /// - If no font with name `fontName` could be found, nil is returned.
    static func bestFitFontSize(for text: String, in bounds: CGRect, fontName: String) -> CGFloat? {
        var maxFontSize: CGFloat = 32.0 // UIKit best renders with factors of 2
        guard let maxFont = UIFont(name: fontName, size: maxFontSize) else {
            return nil
        }
        let textWidth = text.width(withConstraintedHeight: bounds.height, font: maxFont)
        let textHeight = text.height(withConstrainedWidth: bounds.width, font: maxFont)
        // Determine the font scaling factor that should allow the string to fit in the given rect
        let scalingFactor = min(bounds.width / textWidth, bounds.height / textHeight)
        // Adjust font size
        maxFontSize *= scalingFactor
//        print("[Note Resize] scaling: \(maxFontSize)")
        return floor(maxFontSize)
    }
}
fileprivate extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//        print("[Resize] height: \nconstraintRect\n\(constraintRect)\nboundingBox\n\(boundingBox)")
        return ceil(boundingBox.height)
    }
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//        print("[Resize] width: \nconstraintRect\n\(constraintRect)\nboundingBox\n\(boundingBox)")
        return ceil(boundingBox.width)
    }
}
