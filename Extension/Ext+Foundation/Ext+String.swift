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
            fatalError("[Error] \(self) covert Int Type Error")
        }
        return i
    }
    
    var url: URL{
        guard let url = URL(string: self) else {
            fatalError("[Error] \(self) could not be configured.")
        }
        return url
    }
    
    /// "Y" = true
    var yes: Bool{
        guard self == "Y" else{ return false }
        return true
    }
    
    func dateTo(originFormat: String, toFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = originFormat
        guard let date = formatter.date(from: self) else{
            print("[Error] \(self) of format and \(originFormat) isn't equal.")
            return nil
        }
        formatter.dateFormat = toFormat
        return formatter.string(from: date)
    }
}
//extension String{
//    static func - (_ lhs: String, rhs: String) -> String {
//        guard let lhsInt = Int(lhs), let rhsInt = Int(rhs) else{
//            return ""
//        }
//        return String(lhsInt - rhsInt)
//    }
//}
