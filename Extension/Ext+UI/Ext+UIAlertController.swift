//
//  Ext+UIAlertController.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

// MARK: Method
extension UIAlertController{
    /// SwifterExt: initialize and add into alert
    func action(title: String
        , style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil ) -> UIAlertController {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
        return self
    }
}
