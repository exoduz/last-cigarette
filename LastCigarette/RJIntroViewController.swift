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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }

    func setupViews() {
        //self.view.backgroundColor = UIColor(red: 0x52/255.0, green: 0x7a/255.0, blue: 0x9d/255.0, alpha: 1.0)
        self.title = "About Last Cigarette"
        
        //set status bar to light version (NB plist - View controller-based status bar appearance)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background-intro.png")!)
        
        //blur
        let blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        let deviceFrame = CGRectMake(0, 0, Globals.Device.kScreenWidth, Globals.Device.kScreenHeight)
        effectView.frame = deviceFrame
        
        //check device
        var introLabelFontSize: CGFloat = 0
        if (Globals.DeviceType.kIsIPhone5) {
            introLabelFontSize = 20
        } else {
            introLabelFontSize = 21
        }
        
        //create
        let customLabel = CustomLabel()
        let introLabel = customLabel.makeCustomLabel(introLabelFontSize, align: "Center")
        introLabel.text = "Since my last cigarette..."
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let settingsButton = UIButton(type: UIButtonType.System)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.setTitle("Go to Settings", forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "okButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.backgroundColor = UIColor(red: 64/255.0, green: 102.0/255.0, blue: 150.0/255.0, alpha: 0.9)
        settingsButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        let okButton = UIButton(type: UIButtonType.System)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        okButton.setTitle("Gotcha. Let's get started!", forState: UIControlState.Normal)
        okButton.addTarget(self, action: "okButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        okButton.backgroundColor = UIColor(red: 21.0/255.0, green: 32.0/255.0, blue: 64.0/255.0, alpha: 0.9)
        okButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        view.addSubview(effectView)
        view.addSubview(introLabel)
        view.addSubview(settingsButton)
        view.addSubview(okButton)
        
        //constraints
        let viewsDictionary = [
            "introLabel": introLabel,
            "okButton": okButton
        ]
        let metricsDictionary = [
            "introLabelWidth": (Globals.Device.kScreenWidth - 40),
            "introLabelHeight": 200,
            "introLabelLeftConstraint": 20,
            "introLabelRightConstraint": 20,
            "introLabelTopConstraint": 300,
            "okButtonHeight": 60,
            "okButtonWidth": (Globals.Device.kScreenWidth),
            "okButtonLeftConstraint": 0,
            "okButtonRightConstraint": 0,
            "okButtonBottomConstraint": (Globals.Device.kScreenHeight - 60)
        ]
        
        //intro
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-introLabelLeftConstraint-[introLabel(introLabelWidth)]-introLabelRightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-introLabelTopConstraint-[introLabel(introLabelHeight)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        
        //ok button
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-okButtonLeftConstraint-[okButton(okButtonWidth)]-okButtonRightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-okButtonBottomConstraint-[okButton(okButtonHeight)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
    }
    
    func okButtonTapped() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
