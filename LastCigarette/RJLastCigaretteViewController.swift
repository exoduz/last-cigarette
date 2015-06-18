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
    var quitDate: NSDate = NSDate()
    var costPerPack: Float = 0, cigarettesPerPack: Int = 0, smokedPerDay: Int = 0, currency = ""
    
    var dateDuration = "", timeDuration = ""
    var quitDateDurationLabel: UILabel = UILabel()
    var quitTimeDurationLabel: UILabel = UILabel()
    var costLabel: UILabel = UILabel()
    var costPerYearLabel: UILabel = UILabel()
    var numberOfCigarettesLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        hasApplicationBeenLaunchedBefore()
        getData()
        setupViews()
        calculateAndUpdate()
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("calculateAndUpdate"), userInfo: nil, repeats: true) //animate per second
    }
    
    override func viewDidAppear(animated: Bool) {
        if !hasApplicationBeenLaunchedBefore() {
            //if initial launch present intro vc
            let intro = RJIntroViewController()
            self.presentViewController(intro, animated: true, completion: nil)
            
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setBool(true, forKey: "HasBeenLaunched")
            defaults.synchronize()
        }
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
        
        //check device
        var quitDateFontSize: CGFloat = 0, quitTimeFontSize: CGFloat = 0
        if (Global.DeviceType.kIsIPhone5) {
            quitDateFontSize = 25
            quitTimeFontSize = 40
        } else {
            quitDateFontSize = 31
            quitTimeFontSize = 55
        }
        
        var titleLabel = self.makeCustomLabel(20, align: "Center")
        titleLabel.text = "Since my last cigarette..."
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.quitDateDurationLabel = self.makeCustomLabel(quitDateFontSize, align: "Center")
        self.quitDateDurationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.quitTimeDurationLabel = self.makeCustomLabel(quitTimeFontSize, align: "Center")
        self.quitTimeDurationLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        var costTitleLabel = self.makeCustomLabel(19, align: "Left")
        costTitleLabel.text = "Total money saved..."
        costTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.costLabel = self.makeCustomLabel(32, align: "Left")
        self.costLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.costPerYearLabel = self.makeCustomLabel(20, align: "Left")
        self.costPerYearLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        var numberOfCigarettesTitleLabel = self.makeCustomLabel(19, align: "Left")
        numberOfCigarettesTitleLabel.text = "Cigarettes NOT smoked..."
        numberOfCigarettesTitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        self.numberOfCigarettesLabel = self.makeCustomLabel(32, align: "Left")
        self.numberOfCigarettesLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        self.view.addSubview(titleLabel)
        self.view.addSubview(self.quitDateDurationLabel)
        self.view.addSubview(self.quitTimeDurationLabel)
        self.view.addSubview(costTitleLabel)
        self.view.addSubview(self.costLabel)
        self.view.addSubview(self.costPerYearLabel)
        self.view.addSubview(numberOfCigarettesTitleLabel)
        self.view.addSubview(self.numberOfCigarettesLabel)
        
        //constraints
        let viewsDictionary = [
            "titleLabel": titleLabel,
            "quitDateDurationLabel": self.quitDateDurationLabel,
            "quitTimeDurationLabel": self.quitTimeDurationLabel,
            "costTitleLabel": costTitleLabel,
            "costLabel": self.costLabel,
            "costPerYearLabel": self.costPerYearLabel,
            "numberOfCigarettesTitleLabel": numberOfCigarettesTitleLabel,
            "numberOfCigarettesLabel": self.numberOfCigarettesLabel
        ]
        let metricsDictionary = ["leftConstraint": 20.0, "rightConstraint": 20.0, "labelWidth": (Global.Device.kScreenWidth - 40)]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[titleLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[titleLabel(50)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[quitDateDurationLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-165-[quitDateDurationLabel(50)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[quitTimeDurationLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-220-[quitTimeDurationLabel(60)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[costTitleLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(Global.Device.kScreenHeight - 230)-[costTitleLabel(32)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[costLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(Global.Device.kScreenHeight - 200)-[costLabel(32)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[costPerYearLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(Global.Device.kScreenHeight - 168)-[costPerYearLabel(32)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))

        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[numberOfCigarettesTitleLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(Global.Device.kScreenHeight - 120)-[numberOfCigarettesTitleLabel(32)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftConstraint-[numberOfCigarettesLabel(labelWidth)]-rightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(Global.Device.kScreenHeight - 90)-[numberOfCigarettesLabel(32)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
    }
    
    func makeCustomLabel(fontSize: CGFloat, align: String) -> UILabel {
        
        var myLabel: UILabel = UILabel()
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

        let secondsInYear = Global.CalculationConstants.kSecondsInYear
        let secondsInWeek = Global.CalculationConstants.kSecondsInWeek
        let secondsInDay = Global.CalculationConstants.kSecondsInDay
        let secondsInHour = Global.CalculationConstants.kSecondsInHour
        let secondsInMinute = Global.CalculationConstants.kSecondsInMinute
        
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

        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        numberFormatter.maximumFractionDigits = 2
        
        //calculate total costs
        if costPerSecond > 0 {
            costUntilToday = costPerSecond * Float(elapsedTime) //calculate total costs until today
        } else {
            costUntilToday = 0
        }
        
        //calculate total cigarettes
        cigarettesUntilToday = (Float(self.smokedPerDay) / Float(secondsInDay)) * Float(elapsedTime)
        
        //text for duration
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
        
        //update labels
        if (years < 1 && weeks > 0 && days > 0) {
            self.quitDateDurationLabel.text = String(weeks) + "\(weekText)" + String(days) + "\(dayText)"
        } else if (years < 1 && weeks <  1 && days > 0) {
            self.quitDateDurationLabel.text = String(days) + "\(dayText)"
        } else if (years < 1 && weeks <  1 && days < 1) {
            
        } else {
            self.quitDateDurationLabel.text = String(years) + "\(yearText)" + String(weeks) + "\(weekText)" + String(days) + "\(dayText)"
        }
        self.quitTimeDurationLabel.text = String(hours) + "h " + String(format: "%02d", minutes) + "m " + String(format: "%02d", seconds) + "s"
        
        self.costLabel.text = self.currency + numberFormatter.stringFromNumber(costUntilToday)!
        //if stopped over a year then do cost per year
        var costPerYear: Float = 0
        if (years >= 1) {
            costPerYear = (costUntilToday / Float(years))
            self.costPerYearLabel.text = "(" + self.currency + numberFormatter.stringFromNumber(costPerYear)! + " per year)"
        }
        
        self.numberOfCigarettesLabel.text = String(format: "%.0f", cigarettesUntilToday)
    }
    
}

