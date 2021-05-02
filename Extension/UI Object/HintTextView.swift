//
//  HintTextField.swift
//  Swift-Creating-CustomView
//
//  Created by Jeremy Xue on 2020/3/28.
//  Copyright © 2020 jeremyxue. All rights reserved.
//

import UIKit

@IBDesignable
class HintTextView: UIView, NibOwnerLoadable {
    
    var text: String {
        set{
            textField.text = newValue
        }
        get{
            return textField.text ?? ""
        }
    }
    
    enum ValidType {
        case email, password, none
    }
    var validType: ValidType = .none
    
    // MARK: Property
    @IBInspectable var hint: String = "" {
        didSet {
            hintLabel.text = hint
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    @IBInspectable var optinal: Bool = true {
        didSet {
            needFlagLabel.isHidden = optinal
        }
    }
    
    @IBInspectable var errorText: String = "" {
        didSet {
            errorLabel.text = errorText
            errorStackView.isHidden = (errorText == "")
        }
    }
    
    // MARK: IBOutlet
    @IBOutlet weak var needFlagLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorStackView: UIStackView!
    @IBOutlet weak var hintStackView: UIStackView!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupDefault()
    }
    
    // MARK: Initialier
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    // MARK: Custom Init
    private func customInit() {
        loadNibContent()
        setupUI()
    }
    
    private func setupUI() {
        textField.borderWidth = 1
        textField.borderColor = theme.black40.cgColor
        textField.cornerRadius = 6
    }
    
    // MARK: Awake from nib
    fileprivate func setupDefault() {
        hintLabel.text = hint
        textField.placeholder = placeholder
        errorLabel.text = errorText
        needFlagLabel.isHidden = optinal
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: theme.black40])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDefault()
    }
    
    @IBAction func textFieldTouchDown(_ sender: UITextField) {
        errorText = ""
        sender.borderColor = theme.borders.cgColor
    }
    
    @IBAction func textFieldEndAction(_ sender: UITextField) {
        sender.borderColor = UIColor.black.cgColor
    }
    
    func valid() -> Bool {
        guard let text = textField.text else { fatalError("[ERROR] textfield is nil.") }
        if text.isEmpty {
            errorText = FieldError.NIL
            return false
        }
        switch validType {
        case .email:
            let isEmail = text.isValidEmail()
            errorText = isEmail ? "" : FieldError.EMAIL_FORMATTER
            return isEmail
        case .password:
            let isPwd = text.isValidPassword()
            errorText = isPwd ? "" : FieldError.PWD_FORMATTER
            return isPwd
        case .none:
            return true
        }
    }
    
    func validEqual(_ string: String) -> Bool {
        guard let text = textField.text else { fatalError("[ERROR] textfield is nil.") }
        let isValid = text == string
        errorText = isValid ? "" : FieldError.PWD_DIFFERENT
        return isValid
    }
}

private extension String {
    func isValidPassword() -> Bool {
        let pwdRegex = "(?=.*[a-zA-Z])[a-zA-z0-9!?#@$%*&+]{6,}"
        let pwdTest = NSPredicate(format:"SELF MATCHES %@", pwdRegex)
        return pwdTest.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
}
