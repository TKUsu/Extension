//
//  UIView.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

// MARK: - Properties
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

// MARK: - UI Method
extension UIView {
    /// SwifterExt: Reserve Color View, Object: maskRect
    func mask(withRect maskRect: CGRect, cornerRadius: CGFloat, inverse: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if (inverse) {
            path.addPath(UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath)
        }
        path.addPath(UIBezierPath(roundedRect: maskRect, cornerRadius: cornerRadius).cgPath)
        maskLayer.path = path
        if (inverse) {
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        }
        self.layer.mask = maskLayer;
    }
}
