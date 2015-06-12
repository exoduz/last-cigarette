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

func checkInitialLaunch() -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    let defaults = NSUserDefaults.standardUserDefaults()

    var rootViewController : UIViewController;
    
    /*
    if defaults.boolForKey("HasBeenLaunched") {
        //not first time launched
        rootViewController = storyboard.instantiateViewControllerWithIdentifier("MainStoryboard") as! UIViewController
    } else {
        //first time launched
        //set values in info.plist
        defaults.setBool(true, forKey: "HasBeenLaunched")
        defaults.synchronize()
        
        initialPopulate()
        
        //realm file not present (first time opened)
        rootViewController = storyboard.instantiateViewControllerWithIdentifier("IntroStoryboard") as! UIViewController
        
    }
    */
    rootViewController = storyboard.instantiateViewControllerWithIdentifier("IntroStoryboard") as! UIViewController
    
    return rootViewController

}

func initialPopulate() {
    let realm = Realm()
    var results = realm.objects(Cigarette)
    
    var cigarette = Cigarette()
    cigarette.id = "1"
    cigarette.quitDate = NSDate()
    cigarette.smokedPerDay = 0
    cigarette.costPerPack = 0.0
    cigarette.cigarettesPerPack = 0
    cigarette.currency = "$"
    
    // Save initial object
    realm.beginWrite()
    realm.add(cigarette)
    realm.commitWrite()
}