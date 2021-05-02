//
//  Ext+UIColor.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

// MARK: type
extension UIColor{
    /// SwifterExt
    convenience init(R: Int = 255, G: Int = 255, B: Int = 255, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(R) / 255.0,
            green: CGFloat(G) / 255.0,
            blue: CGFloat(B) / 255.0,
            alpha: a
        )
    }
    // SwifterExt
    convenience init(_ hex: Int) {
        self.init(
            R: (hex >> 16) & 0xFF,
            G: (hex >> 8) & 0xFF,
            B: hex & 0xFF
        )
    }
    
    convenience init(_ hex: Int, a: CGFloat = 1.0) {
        self.init(
            R: (hex >> 16) & 0xFF,
            G: (hex >> 8) & 0xFF,
            B: hex & 0xFF,
            a: a
        )
    }
}
