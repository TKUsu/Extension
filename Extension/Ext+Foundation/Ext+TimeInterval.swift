//
//  Ext+TimeInterval.swift
//  Extension
//
//  Created by SuJustin on 2020/1/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

extension TimeInterval{
    /// SwifterExt: format to "mm:ss"
    var clockMin: String{ return String(format: "%02d:%02d", (Int(self) / 60), (Int(self) % 60)) }
}
