//
//  RJSettingsViewController.swift
//  Last Cigarette
//
//  Created by Robin Roy Julius on 26/05/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import UIKit
import RealmSwift

class RJSettingsViewController: UITableViewController {

    @IBOutlet weak var detailLabelQuitDate: UILabel!
    @IBOutlet weak var textFieldNumberSmokedPerDay: UITextField!
    @IBOutlet weak var textFieldCostPerPack: UITextField!
    @IBOutlet weak var textFieldNumberOfCigarettesPerPack: UITextField!
    @IBOutlet weak var textFieldCurrency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //get details
        let realm = Realm()
        let predicate = NSPredicate(format: "id = %@", "1")
        var cigarette = realm.objects(Cigarette).filter(predicate)
        
        self.textFieldNumberSmokedPerDay.text = String(cigarette[0].smokedPerDay)
        self.textFieldCostPerPack.text = "\(cigarette[0].costPerPack)"
        self.textFieldNumberOfCigarettesPerPack.text = String(cigarette[0].cigarettesPerPack)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //if cell clicked then respond
        if indexPath.section == 0 && indexPath.row == 1 {
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldNumberSmokedPerDay.keyboardType = UIKeyboardType.NumberPad
            self.textFieldNumberSmokedPerDay.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldCostPerPack.keyboardType = UIKeyboardType.DecimalPad
            self.textFieldCostPerPack.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 1 {
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.keyboardType = UIKeyboardType.NumberPad
            self.textFieldNumberOfCigarettesPerPack.becomeFirstResponder()
        } else {
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
    
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
        }
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        //save
        let cigarette = Cigarette()
        cigarette.id = "1"
        cigarette.smokedPerDay = self.textFieldNumberSmokedPerDay.text.toInt()!
        cigarette.costPerPack = self.textFieldCostPerPack.text.floatValue
        cigarette.cigarettesPerPack = self.textFieldNumberOfCigarettesPerPack.text.toInt()!
        
        let realm = Realm()
        realm.write {
            realm.add(cigarette, update: true)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func populate() {
        
    }
}
