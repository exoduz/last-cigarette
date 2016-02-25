//
//  StringExtension.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 2/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}

//Convert String to NSDate
func ConverStringToNSDate(date: String, format: String) -> NSDate {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = NSTimeZone()
    
    return dateFormatter.dateFromString(date)!
}

//Convert NSDate To String
func ConvertNSDateToString(date: NSDate, format: String) -> String {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = NSTimeZone()
    
    return dateFormatter.stringFromDate(date)
}