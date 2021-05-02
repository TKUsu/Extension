//
//  DropDownView.swift
//  Lucker
//
//  Created by SuJustin on 2021/4/26.
//

import UIKit

class DropDownView: UIView, NibOwnerLoadable {
    
    var text: String {
        set {
            button.setTitle(newValue, for: .normal)
            placeHolderLabel.isHidden = (newValue != "")
        }
        get {
            return button.titleLabel?.text ?? ""
        }
    }
    var placeHolderText: String {
        set {
            placeHolderLabel.text = newValue
        }
        get {
            return placeHolderLabel.text ?? ""
        }
    }
    var dropdownAction: ((_ dropdownView: DropDownView)->())? = nil
    
    // MARK: Property
    @IBInspectable var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            placeHolderLabel.text = placeholder
        }
    }
    
    @IBInspectable var optinal: Bool = true {
        didSet {
            needFlagLabel.isHidden = optinal
        }
    }
    
    // MARK: IBOutlet
    @IBOutlet weak var needFlagLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var placeHolderLabel: UILabel!
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        titleLabel.text = title
        placeHolderLabel.text = placeholder
        needFlagLabel.isHidden = optinal
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
    }
    
    // MARK: Awake from nib
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = title
        placeHolderLabel.text = placeholder
        needFlagLabel.isHidden = optinal
    }
    @IBAction func action(_ sender: UIButton) {
        dropdownAction?(self)
    }
}
