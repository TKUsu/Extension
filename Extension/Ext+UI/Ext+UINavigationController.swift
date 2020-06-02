//
//  Ext+UINavigationController.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

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
    /// SwifterExt: get from viewcontrollers
    func get<T: UIViewController>(_ viewController: T.Type) -> T? {
        for viewController in self.viewControllers{
            if let choose = viewController as? T{
                return choose
            }
        }
        return nil
    }
    
    @discardableResult
    func pop<T: UIViewController>(To vc: T.Type, animate: Bool = true) -> T? {
        for vc in self.viewControllers{
            guard let findVC = vc as? T else {
                continue
            }
            popToViewController(findVC, animated: animate)
            return findVC
        }
        return nil
    }
}
