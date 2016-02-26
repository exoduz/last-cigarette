//
//  Globals.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 12/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation

struct Globals {
    
    struct App {
        static let kAppId: String = "1088134074"
        static let kBundleIdentifier: String = NSBundle.mainBundle().infoDictionary?["CFBundleIdentifier"] as! String
        static let kVersion: String = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as! String
        static let kBuild: String = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as! String
    }
    
    struct Version {
        static let kVersionNumber: CGFloat = 0.6
        static let kiOSVersionNumber = UIDevice.currentDevice().systemVersion;
    }
    
    struct Device {
        static let kScreenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        static let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    }
    
    struct ScreenSize {
        static let kScreenMaxLength = max(Globals.Device.kScreenWidth, Globals.Device.kScreenHeight)
        static let kScreenMinLength = min(Globals.Device.kScreenWidth, Globals.Device.kScreenHeight)
    }
    
    struct DeviceType {
        static let kIsIPhone4OrLess = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Globals.ScreenSize.kScreenMaxLength < 568.0
        static let kIsIPhone5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Globals.ScreenSize.kScreenMaxLength == 568.0
        static let kIsIPhone6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Globals.ScreenSize.kScreenMaxLength == 667.0
        static let kIsIPhone6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Globals.ScreenSize.kScreenMaxLength == 736.0
        static let kIsIPad = UIDevice.currentDevice().userInterfaceIdiom == .Pad && Globals.ScreenSize.kScreenMaxLength == 1024.0
        
        static var kDeviceName: String {
            var deviceName: String = ""
            
            if Globals.DeviceType.kIsIPhone4OrLess {
                deviceName = "isIPhone40OrLess"
            } else if Globals.DeviceType.kIsIPhone5 {
                deviceName = "kIsIPhone5"
            } else if Globals.DeviceType.kIsIPhone6 {
                deviceName = "kIsIPhone6"
            } else if Globals.DeviceType.kIsIPhone6P {
                deviceName = "kIsIPhone6P"
            }
            
            return deviceName
        }
    }
    
    struct CalculationConstants {
        static let kSecondsInYear = 31536000
        static let kSecondsInWeek = 604800
        static let kSecondsInDay = 86400
        static let kSecondsInHour = 3600
        static let kSecondsInMinute = 60
    }
}

//http://stackoverflow.com/a/26962452/3940083
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,1", "iPad5,3", "iPad5,4":           return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}