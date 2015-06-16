//
//  RJIntroViewController.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 27/05/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import UIKit

class RJIntroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupViews()
    }

    func setupViews() {
        self.view.backgroundColor = UIColor(red: 0x52/255.0, green: 0x7a/255.0, blue: 0x9d/255.0, alpha: 1.0)
        self.title = "About Last Cigarette"
        
        //create 
        let okButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        okButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        okButton.setTitle("Gotcha. Let's get started!", forState: UIControlState.Normal)
        okButton.addTarget(self, action: "okButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        okButton.backgroundColor = UIColor.blueColor()
        okButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        view.addSubview(okButton)
        
        //constraints
        let viewsDictionary = [
            "okButton": okButton
        ]
        let metricsDictionary = [
            "okButtonLeftConstraint": 40.0,
            "okButtonRightConstraint": 40.0,
            "okButtonBottomConstraint": (Global.Device.kScreenHeight - 90),
            "okButtonWidth": (Global.Device.kScreenWidth - 80)
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-okButtonLeftConstraint-[okButton(okButtonWidth)]-okButtonRightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-okButtonBottomConstraint-[okButton(50)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))

    }
    
    func okButtonTapped() {
        //on initial load send to options page
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var vc : UINavigationController;
        vc = storyboard.instantiateViewControllerWithIdentifier("SettingsNavigationController") as! UINavigationController
        self.presentViewController(vc, animated: true, completion: nil)
    }
}
