//
//  Ext+CIFilter.swift
//  Extension
//
//  Created by SuJustin on 2020/5/13.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import UIKit

extension CIFilter{
    enum QRCodeCorrectionLevel: String {
        case L, M, Q, H
    }
    
    static func generalQRcode(qrCodeData: Data, leavel: QRCodeCorrectionLevel) -> CIImage? {
        guard let cifilter = CIFilter(name: "CIQRCodeGenerator") else{
            print("[Error]GeneralQRCode CIQRcodeGenerator can't initial.")
            return nil
        }
        cifilter.setValue(qrCodeData, forKey: "inputMessage")
        cifilter.setValue(leavel.rawValue, forKey: "inputCorrectionLevel")
        guard let image = cifilter.outputImage else{
            print("[Error]GeneralQRCode output image is nil.")
            return nil
        }
        return image
    }
}
