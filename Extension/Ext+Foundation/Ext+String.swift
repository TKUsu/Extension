//
//  Ext+String.swift
//  Extension
//
//  Created by SuJustin on 2020/1/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

extension String{
    /// SwifterExt: 
    var int: Int{
        guard let i = Int(self) else{
            fatalError("\(self) covert Int Type Error")
        }
        return i
    }
}
