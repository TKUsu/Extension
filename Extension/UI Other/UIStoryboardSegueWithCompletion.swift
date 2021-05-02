//
//  UIStoryboardSegueWithCompletion.swift
//  Lucker
//
//  Created by SuJustin on 2021/4/20.
//

import UIKit

class UIStoryboardSegueWithCompletion: UIStoryboardSegue {
    var completion: (() -> Void)?

    override func perform() {
        super.perform()
        if let completion = completion {
            completion()
        }
    }
}
