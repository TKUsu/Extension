//
//  Ext+Bundle.swift
//  Extension
//
//  Created by SuJustin on 2020/1/21.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation

extension Bundle {
    /// SwifterExt: Application Version
    /// - Read "CFBundleShortVersionString"
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    /// SwifterExt: Application Build Version Number
    /// - Read "CFBundleVersion"
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
