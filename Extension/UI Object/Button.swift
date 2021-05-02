//
//  Button.swift
//  Lucker
//
//  Created by SuJustin on 2021/5/1.
//

import UIKit

class Button: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    fileprivate func setupView() {
        tintColor = .black
        
        cornerRadius = 6
//        tintColor = theme.black80
//        backgroundColor = theme.primaryYello
        
//        layer.shadowColor = theme.shadows.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        layer.shadowOpacity = 1
        layer.masksToBounds = false
    }
}
