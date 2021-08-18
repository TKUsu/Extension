//
//  SuperViewController.swift
//  Extension
//
//  Created by SuJustin on 2021/8/18.
//  Copyright © 2021 SuJustin. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Keyboard End Edit Action at Tap View
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Keyboard subscribe Notification
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Keyboard unsubscribe Notification
        unsubscribeFromAllNotifications()
    }
    
    // MARK: - Keyboard 顯示移動相關畫面
    // MARK: Keyboard Variable
    /**
     移動的 View Bottom Constraint
     ```
     override func viewDidLoad() {
         activityBottomConstraint = targetViewBottom
         super.viewDidLoad()
     }
     ```
    */
    var activityBottomConstraint: NSLayoutConstraint?
    
    /**
     移動的 ScrollView
     ```
     override func viewDidLoad() {
         activityBottomConstraint = targetViewBottom
         super.viewDidLoad()
     }
     ```
    */
    var activityScrollView: UIScrollView?
    private var activityBottomOrigin: CGFloat = -99
    private var activityKeyboard: Bool = false
    
    // MARK: Keyboard Function
    /// Keyboard Notification
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        // Get required info out of the notification
        guard activityBottomConstraint != nil,
           let userInfo = notification.userInfo,
           let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
           let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey],
           let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] else {
            return
        }
        // Keyboard Rect
        let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            // 關閉鍵盤
            activityKeyboard = false
            activityBottomConstraint!.constant = activityBottomOrigin
        }else if !activityKeyboard, notification.name == UIResponder.keyboardWillShowNotification {
            // 開啟鍵盤
            activityKeyboard = true
            activityBottomOrigin = activityBottomConstraint!.constant
            if let tabbar = tabBarController {
                activityBottomConstraint!.constant = endRect.height - tabbar.tabBar.frame.size.height
            }else {
                activityBottomConstraint!.constant = endRect.height
            }
        }
        
        
        let duration = (durationValue as AnyObject).doubleValue
        let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
        UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    /**
     keyboard 移動時，ScrollView 跟著滑動
     - parameters view: 滑動到指定的 View。
     ```
     textFieldWillEditing = { cell in
         self.keyboardWillShowToScroll(view: cell)
     }
     ```
    */
    func keyboardWillShowToScroll<T: UIView>(view: T) {
        guard let scrollView = activityScrollView else { return }
        let hintTextSuperFrame = scrollView.convert(view.frame, from: view.superview)
        let hintTextSuperPoint = hintTextSuperFrame.origin
        
        DispatchQueue.main.async {
            scrollView.scrollRectToVisible(CGRect( x: 0, y: hintTextSuperPoint.y, width: scrollView.frame.width, height: scrollView.frame.height ), animated: true)
        }
    }
}
