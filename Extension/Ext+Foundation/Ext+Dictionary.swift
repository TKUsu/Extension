//
//  Ext+Dicnary.swift
//  Extension
//
//  Created by wits on 2019/12/27.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import Foundation

extension Dictionary {
    subscript(string key: Key) -> String? {
        return self[key] as? String ?? nil
    }
    
    subscript(bool key: Key) -> Bool? {
        return self[key] as? Bool ?? nil
    }
    
    subscript(float key: Key) -> Float? {
        return self[key] as? Float ?? nil
    }
    
    subscript(double key: Key) -> Double? {
        return self[key] as? Double ?? nil
    }
    
    subscript(int key: Key) -> Int? {
        return self[key] as? Int ?? nil
    }
    
    subscript(array key: Key) -> Array<Any>? {
        return self[key] as? Array<Any> ?? nil
    }
    
    subscript(dictionary key: Key) -> Dictionary<AnyHashable, Any>? {
        return self[key] as? Dictionary ?? nil
    }
}
