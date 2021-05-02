//
//  Ext+UIViewController.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

extension UIViewController{
    // MARK: Keyboard
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Notification
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// SwifterExt: Is top viewcontroller from windows
    var topVC: UIViewController?{
        if UIApplication.shared.windows.count > 0, var topVC = UIApplication.shared.windows[0].rootViewController{
            while (topVC.presentedViewController != nil) {
                topVC = topVC.presentedViewController!
            }
            return topVC
        }
        return nil
    }
    
    // MARK: show/dismiss ViewController
    func showStoryboardVC<T: UIViewController>(_ viewController: T.Type) -> T? {
        guard let vc = (storyboard?.instantiateViewController(identifier: String(describing: viewController)) as? T) else { return nil }
        addChild(vc)
        vc.view.frame = view.frame
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
        return vc
    }
    
    func dismissStoryboardVC(_ viewController: UIViewController?) {
        guard let vc = viewController else { return }
        vc.willMove(toParent: nil)
        vc.removeFromParent()
        vc.view.removeFromSuperview()
    }
    // Detail
    enum SubViewFrameType {
        case none
        /// equal self frame
        case equalFrame
        case equalSafeArea
        /// equal self superview frame
        case equalSuperview
        case equalTo(_ view: UIView)
    }
    /// SwifterExt: add sub viewController
    /// - Parameters:
    ///   - vc: Sub ViewController
    ///   - type: frame constraint type
    func addSubViewController(_ vc: UIViewController, animated: Bool = true, frame type: SubViewFrameType = .none ) {
        addChild(vc)
        view.addSubview(vc.view)
        
        // Animation
        let subView = vc.view!
        if animated{
            let duration = 0.3
            subView.alpha = 0
            if #available(iOS 10.0, *) {
                let dissmissAnimat = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                    subView.alpha = 1
                }
                dissmissAnimat.addCompletion { (postion) in
                    if postion == .end{
                        vc.didMove(toParent: self)
                    }
                }
                dissmissAnimat.startAnimation()
            } else {
                UIView.animate(withDuration: duration, animations: {
                    subView.alpha = 1
                }) { (isComplete) in
                    vc.didMove(toParent: self)
                }
            }
        }else{
            vc.didMove(toParent: self)
        }
        
        setViewConstraints(type, subView)
    }
    
    /// SwifterExt: remove sub viewController
    /// - Parameter vc: sub viewController
    func removeSubViewController(_ vc: UIViewController?){
        guard vc != nil, let subView = vc!.view else {
            fatalError("[Error] Remove nil view from super viewController.")
        }
        func complete(){
            vc!.willMove(toParent: nil)
            vc!.removeFromParent()
            vc!.view.removeFromSuperview()
        }
        
        // Animation
        let duration = 0.3
        subView.alpha = 1
        if #available(iOS 10.0, *) {
            let dissmissAnimat = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                subView.alpha = 0
            }
            dissmissAnimat.addCompletion { (postion) in
                if postion == .end{
                    complete()
                }
            }
            dissmissAnimat.startAnimation()
        } else {
            UIView.animate(withDuration: duration, animations: {
                subView.alpha = 0
            }) { (isComplete) in
                complete()
            }
        }
    }
    
    // MARK: - Private
    fileprivate func setViewConstraints(_ type: UIViewController.SubViewFrameType, _ subView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .none:
            break
        case .equalFrame:
            NSLayoutConstraint.activate([
                subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                subView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            if #available(iOS 11, *) {
                NSLayoutConstraint.activate([
                    subView.topAnchor.constraint(equalTo: view.topAnchor),
                    view.bottomAnchor.constraint(equalTo: subView.bottomAnchor)])
            } else {
                NSLayoutConstraint.activate([
                    subView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                    bottomLayoutGuide.topAnchor.constraint(equalTo: subView.bottomAnchor)])
            }
        case .equalSafeArea:
            NSLayoutConstraint.activate([
                subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                subView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            if #available(iOS 11, *) {
                let guide = view.safeAreaLayoutGuide
                NSLayoutConstraint.activate([
                    subView.topAnchor.constraint(equalTo: guide.topAnchor),
                    guide.bottomAnchor.constraint(equalTo: subView.bottomAnchor)])
            } else {
                NSLayoutConstraint.activate([
                    subView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor),
                    bottomLayoutGuide.topAnchor.constraint(equalTo: subView.bottomAnchor)])
            }
        case .equalSuperview:
            guard let v = view.superview else {
                setViewConstraints(.equalFrame, subView)
                print("[Error] view haven't superview, and set frame use `equalFrame` model.")
                return
            }
            NSLayoutConstraint.activate([
                subView.leadingAnchor.constraint(equalTo: v.leadingAnchor),
                subView.trailingAnchor.constraint(equalTo: v.trailingAnchor),
                subView.topAnchor.constraint(equalTo: v.topAnchor),
                v.bottomAnchor.constraint(equalTo: subView.bottomAnchor)
            ])
        case .equalTo(let view):
            NSLayoutConstraint.activate([
                subView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                subView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                subView.topAnchor.constraint(equalTo: view.topAnchor),
                view.bottomAnchor.constraint(equalTo: subView.bottomAnchor)
            ])
        }
    }
}
