//
//  MutlipleOptionCollectionViewCell.swift
//  Lucker
//
//  Created by SuJustin on 2021/4/28.
//

import UIKit

class MultipleOptionCollectionViewCell: UICollectionViewCell {

    var text: String {
        set {
            textLabel.text = newValue
        }
        get {
            return textLabel.text ?? ""
        }
    }
    
    override var isSelected: Bool {
        didSet {
            view.backgroundColor = isSelected ? .black : .white
            textLabel.textColor = isSelected ? .white : .black
//            print("[Test] \(text) isSelected: \(isSelected)")
        }
    }
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.backgroundColor = .white
    }
}
