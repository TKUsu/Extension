//
//  Ext+UINavigationController.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

// MARK: - Properties
extension UINavigationController{
    /// SwifterExt
    var rootViewController: UIViewController? {
        guard let count = navigationController?.viewControllers.count,
            count > 0 else {
            print("[Warning] Navigation haven't any viewController")
            return nil
        }
        guard let vc = navigationController?.viewControllers[0] else{
            print("[Warning] Not found LoginViewController")
            return nil
        }
        return vc
    }
}

// MARK: - Method
extension UINavigationController{
    /// SwifterExt: get from viewcontrollers
    func get<T: UIViewController>(_ viewController: T.Type) -> T? {
        for viewController in self.viewControllers{
            if let choose = viewController as? T{
                return choose
            }
        }
        return nil
    }
}
