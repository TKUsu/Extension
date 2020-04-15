//
//  Ext+Date.swift
//  Extension
//
//  Created by SuJustin on 2020/1/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

extension String{
    /// SwifterExt
    func date(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else{ return nil }
        return date
    }
}

extension Date{
    /// SwifterExt
    func string(_ format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    var weekend: String{
        let dataFormatter = DateFormatter()
        dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
        dataFormatter.dateFormat = "EEEE"
        return dataFormatter.string(from: self)
    }
}
