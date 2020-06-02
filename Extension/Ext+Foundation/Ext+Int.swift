//
//  Ext+Int.swift
//  Extension
//
//  Created by SuJustin on 2020/1/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

extension Int{
    /// SwifterExt: format to "mm:ss"
    var clockMin: String{ return String(format: "%02d:%02d", (self / 60), (self % 60)) }
    
    var HH: Int{
        return self / 10000
    }
    var mm: Int{
        return (self % 10000) / 100
    }
    var ss: Int{
        return (self % 100)
    }
}
