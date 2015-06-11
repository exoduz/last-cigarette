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
    
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    let secondsInYear = 31536000, secondsInWeek = 604800, secondsInDay = 86400, secondsInHour = 3600, secondsInMinute = 60
    var timer = NSTimer()
    var quitDate: NSDate = NSDate()
    var costPerPack: Float = 0, cigarettesPerPack: Int = 0, smokedPerDay: Int = 0, currency = ""
    
    var dateDuration = "", timeDuration = ""
    var quitDateDurationLabel: UILabel = UILabel()
    var quitTimeDurationLabel: UILabel = UILabel()
    
    @IBOutlet weak var labelSaved: UILabel!
    @IBOutlet weak var labelNumberOfCigarettes: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        getData()
        setupViews()
        calculateAndUpdate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("calculateAndUpdate"), userInfo: nil, repeats: true) //animate per second
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViews() {
        //set status bar to light version (NB plist - View controller-based status bar appearance)
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        var titleLabel = self.makeCustomLabel("HelveticaNeue-light", fontSize: 20.0)
        titleLabel.text = "Since my last cigarette..."
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(titleLabel)
        
        self.quitDateDurationLabel = self.makeCustomLabel("HelveticaNeue-UltraLight", fontSize: 30)
        self.quitDateDurationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.quitDateDurationLabel)
        
        self.quitTimeDurationLabel = self.makeCustomLabel("HelveticaNeue-Ultralight", fontSize: 55)
        self.quitTimeDurationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.view.addSubview(self.quitTimeDurationLabel)
        
        
        //constraints
        let viewsDictionary = ["titleLabel": titleLabel, "quitDateDurationLabel": self.quitDateDurationLabel, "quitTimeDurationLabel": self.quitTimeDurationLabel]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[titleLabel(\(self.screenWidth - 40))]-20-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-130-[titleLabel(50)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[quitDateDurationLabel(\(self.screenWidth - 40))]-20-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-190-[quitDateDurationLabel(50)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[quitTimeDurationLabel(\(self.screenWidth - 40))]-20-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-260-[quitTimeDurationLabel(60)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary))
    }
    
    func makeCustomLabel(fontFamily: String, fontSize: CGFloat) -> UILabel {
        
        var myLabel: UILabel = UILabel()
        //myLabel.frame = CGRectMake(0, y, self.screenWidth, 100) //no need to make size as it's set up in addConstraints
        myLabel.textAlignment = .Center
        myLabel.textColor = UIColor.whiteColor()
        //myLabel.backgroundColor = UIColor.greenColor()
        
        var fontUsed = ""
        if fontFamily != "" {
            fontUsed = fontFamily
        } else {
            fontUsed = "HelveticaNeue"
        }
        myLabel.font = UIFont (name: fontUsed, size: fontSize)
        //myLabel.font = myLabel.font.fontWithSize(fontSize) //only set font size
        
        return myLabel
    }
    
    func getData() {
        //get details
        let realm = Realm()
        let predicate = NSPredicate(format: "id = %@", "1")
        var cigarette = realm.objects(Cigarette).filter(predicate)
        
        self.quitDate = cigarette[0].quitDate
        self.smokedPerDay = cigarette[0].smokedPerDay
        self.costPerPack = cigarette[0].costPerPack
        self.cigarettesPerPack = cigarette[0].cigarettesPerPack
        self.currency = cigarette[0].currency
    }
    
    func calculateAndUpdate() {
        let date = NSDate(); //current UTC time
        let convertedDate:NSDate = self.quitDate

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
        
        //calculate cost per cigarette per second
        costPerDay = (self.costPerPack / Float(self.cigarettesPerPack)) * Float(self.smokedPerDay)
        costPerSecond = costPerDay / Float(secondsInDay)
        
        //calculate total costs
        costUntilToday = costPerSecond * Float(elapsedTime) //calculate total costs until today
        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberFormatter.maximumFractionDigits = 2
        
        //calculate total cigarettes
        cigarettesUntilToday = (Float(self.smokedPerDay) / Float(secondsInDay)) * Float(elapsedTime)
        
        //update label
        
        var yearText = "", weekText = "", dayText = ""
        if (years <= 1) {
            yearText = "year "
        } else {
            yearText = "years "
        }
        if (weeks <= 1) {
            weekText = "week "
        } else {
            weekText = "weeks "
        }
        if (days <= 1) {
            dayText = "day "
        } else {
            dayText = "days "
        }
        
        if (years < 1 && weeks > 0 && days > 0) {
            self.quitDateDurationLabel.text = String(weeks) + "\(weekText)" + String(days) + "\(dayText)"
        } else if (years < 1 && weeks <  1 && days > 0) {
            self.quitDateDurationLabel.text = String(days) + "\(dayText)"
        } else if (years < 1 && weeks <  1 && days < 1) {
            
        } else {
            self.quitDateDurationLabel.text = String(years) + "\(yearText)" + String(weeks) + "\(weekText)" + String(days) + "\(dayText)"
        }
        self.quitTimeDurationLabel.text = String(hours) + "h " + String(format: "%02d", minutes) + "m " + String(format: "%02d", seconds) + "s"

        labelSaved.text = self.currency + numberFormatter.stringFromNumber(costUntilToday)!
        labelNumberOfCigarettes.text = String(format: "%.2f", cigarettesUntilToday)
    }
    
}

