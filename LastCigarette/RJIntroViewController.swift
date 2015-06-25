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
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        
        //blur
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        var deviceFrame = CGRectMake(0, 0, Globals.Device.kScreenWidth, Globals.Device.kScreenHeight)
        effectView.frame = deviceFrame
        
        //check device
        var quitDateFontSize: CGFloat = 0, quitTimeFontSize: CGFloat = 0
        if (Globals.DeviceType.kIsIPhone5) {
            quitDateFontSize = 25
            quitTimeFontSize = 40
        } else {
            quitDateFontSize = 31
            quitTimeFontSize = 55
        }
        
        //create
        var customLabel = CustomLabel()
        var titleLabel = customLabel.makeCustomLabel(20, align: "Center")
        titleLabel.text = "Since my last cigarette..."
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        let okButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        okButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        okButton.setTitle("Gotcha. Let's get started!", forState: UIControlState.Normal)
        okButton.addTarget(self, action: "okButtonTapped", forControlEvents: UIControlEvents.TouchUpInside)
        okButton.backgroundColor = UIColor.blueColor()
        okButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        view.addSubview(effectView)
        view.addSubview(titleLabel)
        view.addSubview(okButton)
        
        //constraints
        let viewsDictionary = [
            "okButton": okButton
        ]
        let metricsDictionary = [
            "okButtonHeight": 60,
            "okButtonLeftConstraint": 0,
            "okButtonRightConstraint": 0,
            "okButtonBottomConstraint": (Globals.Device.kScreenHeight - 60),
            "okButtonWidth": (Globals.Device.kScreenWidth)
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-okButtonLeftConstraint-[okButton(okButtonWidth)]-okButtonRightConstraint-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-okButtonBottomConstraint-[okButton(okButtonHeight)]|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: metricsDictionary, views: viewsDictionary))
    }
    
    func okButtonTapped() {
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
