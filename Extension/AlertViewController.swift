//
//  AlertViewController.swift
//  ClockIn
//
//  Created by SuJustin on 2019/12/18.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

public typealias AlertActionHandle = ((_ sender: UIButton)->())
class AlertViewController: UIViewController {
    static var shared: AlertViewController{
        return AlertViewController(nibName: "AlertViewController", bundle: nil)
    }
    
    var viewRadius: CGFloat{
        set{
            alertView.layer.cornerRadius = newValue
        }
        get{
            return alertView.layer.cornerRadius
        }
    }
    
    var closeHandle: AlertActionHandle? = nil
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var alertView: UIView!
    
    @IBOutlet weak var LBl_title: UILabel!
    @IBOutlet weak var Lbl_subTitle: UILabel!
    @IBOutlet weak var Lbl_message: UILabel!
    
    @IBOutlet weak var Btn_close: UIButton!
    @IBOutlet weak var Btn_action: UIButton!
    @IBOutlet weak var Btn_action2: UIButton!
    
    private var titleText: String?
    private var text: String?
    private var subTitle: String?
    private var action: (hidden: Bool, title: String?, handle: AlertActionHandle?) = (true, nil, nil)
    private var action2: (hidden: Bool, title: String?, handle: AlertActionHandle?) = (true, nil, nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        resetView()
    }
    
    @IBAction func action1(_ sender: UIButton) {
        closeAction{ [weak self] in
            self?.action.handle?(sender)
        }
    }
    @IBAction func action2(_ sender: UIButton) {
        closeAction{ [weak self] in
            self?.action2.handle?(sender)
        }
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        if let closeHandle = closeHandle{
            closeAction {
                closeHandle(sender)
            }
        }else{
            closeAction {
                
            }
        }
    }
}
// MARK: Private
extension AlertViewController{
    fileprivate func resetView() {
        action.hidden = true
        action2.hidden = true
        
        LBl_title.text = ""
        LBl_title.isHidden = true
        Lbl_subTitle.text = ""
        Lbl_subTitle.isHidden = true
        Lbl_message.text = ""
        Lbl_message.isHidden = true
    }
    
    fileprivate func setupView() {
        bgView.backgroundColor = theme.text.withAlphaComponent(0.45)
        
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 10
        
        // FBL
        LBl_title.textColor = theme.mainBlueGreen
        Lbl_subTitle.textColor = theme.alertText
        Lbl_message.textColor = theme.alertText
        Btn_action.tintColor = .white
        Btn_action.backgroundColor = theme.mainBlueGreen
        Btn_action2.tintColor = .white
        Btn_action2.backgroundColor = theme.mainBlueGreen
    }
    fileprivate func setup(){
        setupView()
        
        Btn_action.isHidden = action.hidden
        Btn_action.setTitle(action.title, for: .normal)
        Btn_action2.isHidden = action2.hidden
        Btn_action2.setTitle(action2.title, for: .normal)
        
        LBl_title.text = titleText
        LBl_title.isHidden = (titleText == nil)
        Lbl_subTitle.text = subTitle
        Lbl_subTitle.isHidden = (subTitle == nil)
        Lbl_message.text = text
        Lbl_message.isHidden = (text == nil)
        Lbl_message.sizeToFit()
    }
    /// Close Alert
    fileprivate func closeAction(complete: @escaping (()->()) ){
        dismiss(animated: true) {
          // at parent dismiss
            complete()
        }
    }
}
// MARK: Public
extension AlertViewController{
    func set(title: String?, subTitle: String?, msg: String?) {
        self.titleText = title
        self.subTitle = subTitle
        self.text = msg
    }
    
    func addAction(title: String?, _ actionHandle: AlertActionHandle? = nil ) {
        action.hidden = (title == nil)
        action.title = title
        action.handle = actionHandle
    }
    func addAction2(title: String?, _ actionHandle: AlertActionHandle? = nil ) {
        action2.hidden = (title == nil)
        action2.title = title
        action2.handle = actionHandle
    }
}
