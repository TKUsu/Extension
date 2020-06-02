//
//  Ext+UILabel.swift
//  Extension
//
//  Created by SuJustin on 2020/1/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

extension UILabel{
    func resize() {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.infinity))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: label.frame.height)
    }
}
