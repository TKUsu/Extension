//
//  DeviceType.swift
//  ClockIn
//
//  Created by SuJustin on 2019/11/26.
//  Copyright © 2019 SuJustin. All rights reserved.
//  Swift5_iOS 13

import UIKit

/// SwifterExt: The screen sizes for all available iPhone's and iPad's
///
/// - iPhone3_5: 3.5 inch iPhone (4, 4S)
/// - iPhone4_0: 4.0 inch iPhone (5, 5S, 5C, SE)
/// - iPhone4_7: 4.7 inch iPhone (6, 7, 8)
/// - iPhone5_5: 5.5 inch iPhone (6+, 7+, 8+)
/// - iPhone5_8: 5.8 inch iPhone (X, XS, 11 Pro(new))
/// - iPhone6_1: 6.1 inch iPhone (XR, 11(new))
/// - iPhone6_5: 6.5 inch iPhone (XS Max, 11 ProMax(new))
/// - iPad9_7: 9.7 inch iPad
/// - iPad10_2: 10.2 inch iPad
/// - iPad10_5: 10.5 inch iPad
/// - iPad11: 11 inch iPad
/// - iPad12_9: 12.9 inch iPad
/// - unknown: Couldn't determine device
@objc public enum ScreenType: Int {
    /// 3.5 inch iPhone [4, 4S]
    case iPhone3_5 = 0
    
    /// 4.0 inch iPhone [5, 5S, 5C, SE]
    case iPhone4_0
    
    /// 4.7 inch iPhone [6, 7, 8]
    case iPhone4_7
    
    /// 5.5 inch iPhone [6+, 7+, 8+]
    case iPhone5_5
    
    /// 5.8 inch iPhone [X, XS, 11 Pro(new)]
    case iPhone5_8
    
    /// 6.1 inch iPhone [XR, 11(new)]
    case iPhone6_1
    
    /// 6.5 inch iPhone [XS Max, 11 ProMax(new)]
    case iPhone6_5
    
    /// 9.7  inch iPad
    case iPad9_7
    
    /// 10.2 inch iPad
    case iPad10_2
    
    /// 10.5 inch iPad
    case iPad10_5
    
    /// 11   inch iPad
    case iPad11
    
    /// 12.9 inch iPad
    case iPad12_9
    
    /// Couldn't determine device
    case overSize
}

extension ScreenType: Comparable {
    public static func < (lhs: ScreenType, rhs: ScreenType) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    public static func > (lhs: ScreenType, rhs: ScreenType) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
}

extension UIScreen {
    /// Screen Size
    var absSize: CGSize{
        return CGSize(width: (bounds.width * scale), height: (bounds.height * scale))
    }
    
    /// SwifterExt
    static var screenLongestSide: CGFloat{
        return max(main.bounds.width, main.bounds.height)
    }
    static var iPad: Bool{
        return (current >= .iPad9_7) || (screenLongestSide >= 1024)
    }
    /// SwifterExt: Get iPhone/iPad current type
    @objc public static var current: ScreenType {
        let size = screenLongestSide
        if 480 <= size{
            return .iPhone3_5
        }else if size <= 568 {
            return .iPhone4_0
        }else if size <= 667 {
            return .iPhone4_7
        }else if size <= 736 {
            return .iPhone5_5
        }else if size <= 812 {
            return .iPhone5_8
        }else if size <= 896 {
            return main.scale == 3 ? .iPhone6_5 : .iPhone6_1
        }else if size <= 1024 {
            return .iPad9_7
        }else if size <= 1080 {
            return .iPad10_2
        }else if size <= 1112 {
            return .iPad10_5
        }else if size <= 1194 {
            return .iPad11
        }else if size <= 1366 {
            return .iPad12_9
        }else {
            return .overSize
        }
    }
}
