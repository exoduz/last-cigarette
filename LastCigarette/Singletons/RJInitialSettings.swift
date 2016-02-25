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
    
    //check plist whether app has been launched before
    if defaults.boolForKey("HasBeenLaunched") {
        return true
    } else {
        return false
    }
}

func hasOptionsBeenPresentedBefore() -> Bool {
    let defaults = NSUserDefaults.standardUserDefaults()

    //check plist whether options has been presented before
    if defaults.boolForKey("HasOptionsBeenPresented") {
        return true
    } else {
        return false
    }
}

func initialPopulate() {
    do {
        let realm = try Realm()
        let predicate = NSPredicate(format: "id = %@", "1")
        let cigarette = realm.objects(Cigarette).filter(predicate)
        
        if Int(cigarette.count) == 0 {
            let initialCigarette = Cigarette()
            initialCigarette.id = "1"
            initialCigarette.quitDate = NSDate()
            initialCigarette.smokedPerDay = 0
            initialCigarette.costPerPack = 0.0
            initialCigarette.cigarettesPerPack = 0
            initialCigarette.currency = "$"
            
            // Save initial object
            realm.beginWrite()
            realm.add(initialCigarette)
            try realm.commitWrite()
        }
    } catch {
        print(error)
    }
}