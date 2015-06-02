//
//  RJLastCigaretteViewController.swift
//  Last Cigarette
//
//  Created by Robin Roy Julius on 21/05/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift

class RJLastCigaretteViewController: UIViewController {
    
    var timer = NSTimer()
    var startDate: String = ""
    var costPerPack: Float = 0, cigarettesPerPack: Int = 0, smokedPerDay: Int = 0
    
    @IBOutlet weak var labelYears: UILabel!
    @IBOutlet weak var labelWeeks: UILabel!
    @IBOutlet weak var labelDays: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelMinutes: UILabel!
    @IBOutlet weak var labelSeconds: UILabel!
    @IBOutlet weak var labelSaved: UILabel!
    @IBOutlet weak var labelNumberOfCigarettes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //get all variables
        self.startDate = "2010-12-03 10:33:00"
        self.costPerPack = 25.00
        self.cigarettesPerPack = 20
        self.smokedPerDay = 18
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("calculateAndUpdate"), userInfo: nil, repeats: true) //animate per second
        
        //animate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculateAndUpdate() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //set format and locale

        let date = NSDate(); //current UTC time
        let convertedDate:NSDate = dateFormatter.dateFromString(self.startDate)!
        let secondsInYear = 31536000, secondsInWeek = 604800, secondsInDay = 86400, secondsInHour = 3600, secondsInMinute = 60

        var elapsedTime = NSDate().timeIntervalSinceDate(convertedDate) //get the interval in seconds between the 2 dates
        var years = 0, weeks = 0, days = 0, hours = 0, minutes = 0, seconds = 0
        var remainderWeeks = 0, remainderDays = 0, remainderHours = 0, remainderMinutes = 0, remainderSeconds = 0
        var costPerDay:Float = 0, costPerSecond: Float = 0
        var costUntilToday: Float = 0, cigarettesUntilToday: Float = 0
        
        //calculate elapsed time
        years = Int(elapsedTime) / secondsInYear
        remainderWeeks = Int(elapsedTime) % secondsInYear
        
        weeks = remainderWeeks / secondsInWeek
        remainderDays = remainderWeeks % secondsInWeek
        
        days = remainderDays / secondsInDay
        remainderHours = remainderDays % secondsInDay

        hours = remainderHours / secondsInHour
        remainderMinutes = remainderHours % secondsInHour
        
        minutes = remainderMinutes / secondsInMinute
        remainderSeconds = remainderMinutes % secondsInMinute
    
        seconds = remainderSeconds
        
        labelYears.text = String(years)
        labelWeeks.text = String(weeks)
        labelDays.text = String(days)
        labelHours.text = String(hours)
        labelMinutes.text = String(minutes)
        labelSeconds.text = String(seconds)
        
        //calculate cost per cigarette per second
        costPerDay = (self.costPerPack / Float(self.cigarettesPerPack)) * Float(self.smokedPerDay)
        costPerSecond = costPerDay / Float(secondsInDay)
        
        //calculate total costs
        costUntilToday = costPerSecond * Float(elapsedTime) //calculate total costs until today
        labelSaved.text = String(format: "$%.2f", costUntilToday)
        
        //calculate total cigarettes
        cigarettesUntilToday = (Float(self.smokedPerDay) / Float(secondsInDay)) * Float(elapsedTime)
        labelNumberOfCigarettes.text = String(format: "%.2f", cigarettesUntilToday)
    }
}

