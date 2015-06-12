//
//  Globals.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 12/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation

struct Globals {
    struct Device {
        static let kScreenWidth: CGFloat = UIScreen.mainScreen().bounds.width
        static let kScreenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    }
    
    struct CalculationConstants {
        static let kSecondsInYear = 31536000
        static let kSecondsInWeek = 604800
        static let kSecondsInDay = 86400
        static let kSecondsInHour = 3600
        static let kSecondsInMinute = 60
    }
    
}