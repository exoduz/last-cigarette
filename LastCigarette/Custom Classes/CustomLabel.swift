//
//  CustomLabel.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 19/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation

class CustomLabel: UILabel {
    
    func makeCustomLabel(fontSize: CGFloat, align: String) -> UILabel {
        
        let myLabel: UILabel = UILabel()
        //myLabel.frame = CGRectMake(0, y, Global.Device.screenWidth, 100) //no need to make size as it's set up in addConstraints
        if align == "Right" {
            myLabel.textAlignment = .Right
        } else if align == "Center" {
            myLabel.textAlignment = .Center
        } else {
            myLabel.textAlignment = .Left
        }
        myLabel.textColor = UIColor.whiteColor()
        myLabel.font = UIFont (name: "HelveticaNeue-Thin", size: fontSize)
        //myLabel.font = myLabel.font.fontWithSize(fontSize) //only set font size
        
        return myLabel
    }
}