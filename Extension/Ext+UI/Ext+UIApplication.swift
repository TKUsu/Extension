//
//  Ext+UIApplication.swift
//  CallCar
//
//  Created by SuJustin on 2021/4/10.
//

import UIKit

extension UIApplication {
    static var windowScene: UIWindowScene? {
        return UIApplication.shared.connectedScenes.first as? UIWindowScene
    }
    
    static var sceneDelegate: SceneDelegate? {
        return windowScene?.delegate as? SceneDelegate
    }
}
