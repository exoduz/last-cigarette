//
//  RJAboutViewController.swift
//  LastCigarette
//
//  Created by Robin Roy Julius on 12/06/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import UIKit
import Foundation

class RJAboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor(red: 0x52/255.0, green: 0x7a/255.0, blue: 0x9d/255.0, alpha: 1.0)
        self.title = "About Last Cigarette"
    }
}
