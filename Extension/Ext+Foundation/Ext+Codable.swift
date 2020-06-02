//
//  Ext+Decode.swift
//  ClockIn
//
//  Created by SuJustin on 2019/11/25.
//  Copyright © 2019 SuJustin. All rights reserved.
//  Swift5_iOS 13

import Foundation
import CommonCrypto

/* ======================== Eecoder ======================== */

extension String{
    /// SwifterExt: 'CC_MD5' was deprecated in iOS 13.0: This function is cryptographically broken and should not be used in security contexts. Clients should migrate to SHA256 (or stronger).
    var md5: String! {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deallocate()
        return String(format: hash as String)
    }
}

extension Encodable {
    /// SwifterExt: encoding to Data
    func encodeData() throws -> Data? {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
}
extension Dictionary{
    /// SwifterExt: Use JSONSerialization.data()
    /// - default options = []
    func toData(options: JSONSerialization.WritingOptions = []) -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch  {
            print("[Error] Dictionary isn't to Data: \(error) _Ext+Decode")
        }
        return nil
    }
}
extension Data{
    /// SwifterExt: Use JSONSerialization.jsonObject()
    /// - default options = []
    func toDic(options: JSONSerialization.ReadingOptions = []) -> Dictionary<String, Any>? {
        do{
            return try JSONSerialization.jsonObject(with: self, options: options) as? Dictionary<String, Any>
        }catch{
            print("[Error] Data isn't to Dictionary: \(error) _Ext+Decode")
        }
        return nil
    }
    /// append string into data (using: .utf8)
    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

/* ======================== Decoder ======================== */
extension Data{
    /// SwifterExt: Device Token String
    var tokenStr: String{
        return self.reduce("") {
            return $0 + String(format: "%02x", $1)
        }
    }
}

extension Decodable {
    /// SwifterExt: decoding Dictionary -> Data -> Struct(JSON)
    static func decode(dic: Dictionary<AnyHashable, Any>) -> Self? {
        let decoder = JSONDecoder()
        do{
            return try decoder.decode(Self.self, from: dic.toData()!)
        }catch{
            print("[Error] JSON Dic Decoder faild: \(error) _Ext+Decode")
            return nil
        }
    }
    /// SwifterExt: decoding Data -> JSON-Structure
    static func decode(data: Data) -> Self? {
        let decoder = JSONDecoder()
        do{
            return try decoder.decode(Self.self, from: data)
        }catch{
            print("[Error] JSON Data Decoder faild: \(error) _Ext+Decode")
            return nil
        }
    }
    /// SwifterExt: decoding -> JSON-Structure
    static func decode(_ string: String) -> Self? {
        let decoder = JSONDecoder()
        do{
            guard let data = string.data(using: .utf8) else{
                print("[Error] JSON Decoder faild.")
                return nil
            }
            return try decoder.decode(Self.self, from: data)
        }catch{
            print("[Error] JSON Decoder faild.\n\(error)")
            return nil
        }
    }
}

