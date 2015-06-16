//
//  Globals.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 12/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation

struct Global {
    
    struct Application {
        static let kApplicationHasBeenLaunchedBefore = initialLaunchChecks()
    }

    struct Device {
        static let kScreenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        static let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    }
    
    struct ScreenSize {
        static let kScreenMaxLength    = max(Global.Device.kScreenWidth, Global.Device.kScreenHeight)
        static let kScreenMinLength    = min(Global.Device.kScreenWidth, Global.Device.kScreenHeight)
    }
    
    struct DeviceType {
        static let kIsIPhone4OrLess = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Global.ScreenSize.kScreenMaxLength < 568.0
        static let kIsIPhone5 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Global.ScreenSize.kScreenMaxLength == 568.0
        static let kIsIPhone6 = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Global.ScreenSize.kScreenMaxLength == 667.0
        static let kIsIPhone6P = UIDevice.currentDevice().userInterfaceIdiom == .Phone && Global.ScreenSize.kScreenMaxLength == 736.0
        static let kIsIPad = UIDevice.currentDevice().userInterfaceIdiom == .Pad && Global.ScreenSize.kScreenMaxLength == 1024.0
    }
    
    struct CalculationConstants {
        static let kSecondsInYear = 31536000
        static let kSecondsInWeek = 604800
        static let kSecondsInDay = 86400
        static let kSecondsInHour = 3600
        static let kSecondsInMinute = 60
    }
    
}