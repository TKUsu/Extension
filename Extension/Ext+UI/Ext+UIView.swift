//
//  UIView.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

// MARK: Object
extension UIView{
    /// SwifterExt
    @IBInspectable var cornerRadius: CGFloat {
        set{
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
    /// SwifterExt
    @IBInspectable var borderWidth: CGFloat{
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    /// SwifterExt
    @IBInspectable var borderColor: CGColor?{
        set{
            layer.borderColor = newValue
        }
        get{
            return layer.borderColor
        }
    }
    /// SwifterExt
    var minWidth: CGFloat{
        return min(bounds.width, bounds.height)
    }
}
