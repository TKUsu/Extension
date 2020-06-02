//
//  Ext+UI.swift
//  ClockIn
//
//  Created by SuJustin on 2019/11/25.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

extension UIStoryboard{
    /// SwifterExt
    var main: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    /// SwifterExt
    func instantiate<T: UIViewController>(_ viewController: T.Type) -> UIViewController? {
        guard let vc = self.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else{
            return nil
        }
        return vc
    }
}
