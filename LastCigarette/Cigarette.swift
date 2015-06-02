//
//  Cigarette.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 2/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation
import RealmSwift

class Cigarette: Object {
    
    dynamic var id = ""
    dynamic var quitDate: NSDate = NSDate()
    dynamic var smokedPerDay = 0
    dynamic var costPerPack: Float = 0.0
    dynamic var cigarettesPerPack = 0
    dynamic var currency = "$"
    
    override static func primaryKey() -> String? {
        return "id"
    }

}

