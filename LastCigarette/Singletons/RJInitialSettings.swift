//
//  RJInitialSettings.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 2/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

func hasApplicationBeenLaunchedBefore() -> Bool {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    if defaults.boolForKey("HasBeenLaunched") {
        //not first time launched
        return true
    } else {
        //first time launched
        //set values in info.plist
        initialPopulate()
        
        return false
        
    }
}

func initialPopulate() {
    let realm = Realm()
    let predicate = NSPredicate(format: "id = %@", "1")
    var cigarette = realm.objects(Cigarette).filter(predicate)
    
    if Int(cigarette.count) == 0 {
        var initialCigarette = Cigarette()
        initialCigarette.id = "1"
        initialCigarette.quitDate = NSDate()
        initialCigarette.smokedPerDay = 0
        initialCigarette.costPerPack = 0.0
        initialCigarette.cigarettesPerPack = 0
        initialCigarette.currency = "$"
        
        // Save initial object
        realm.beginWrite()
        realm.add(initialCigarette)
        realm.commitWrite()
    }
}