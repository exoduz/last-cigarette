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
    
    var quitDate: NSDate = NSDate()
    
    @IBOutlet weak var labelQuitDate: UILabel!
    @IBOutlet weak var textFieldNumberSmokedPerDay: UITextField!
    @IBOutlet weak var textFieldCostPerPack: UITextField!
    @IBOutlet weak var textFieldNumberOfCigarettesPerPack: UITextField!
    @IBOutlet weak var labelCurrency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //get details
        let realm = Realm()
        let predicate = NSPredicate(format: "id = %@", "1")
        var cigarette = realm.objects(Cigarette).filter(predicate)
        self.quitDate = cigarette[0].quitDate
        
        self.labelQuitDate.text = ConvertNSDateToString(cigarette[0].quitDate, "d MMM yyyy h:mm a")
        self.textFieldNumberSmokedPerDay.text = "\(cigarette[0].smokedPerDay)"
        self.textFieldCostPerPack.text = "\(cigarette[0].costPerPack)"
        self.textFieldNumberOfCigarettesPerPack.text = "\(cigarette[0].cigarettesPerPack)"
        self.labelCurrency.text = "\(cigarette[0].currency)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        self.labelQuitDate.resignFirstResponder()
        self.textFieldNumberSmokedPerDay.resignFirstResponder()
        self.textFieldCostPerPack.resignFirstResponder()
        self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
        self.labelCurrency.resignFirstResponder()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //respond to cell tap
        if indexPath.section == 0 && indexPath.row == 0 {
            showQuitDateActionSheet()
        } else if indexPath.section == 0 && indexPath.row == 1 {
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
        } else if indexPath.section == 1 && indexPath.row == 2 {
            showCurrencyActionSheet()
        } else {
            self.labelQuitDate.resignFirstResponder()
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            self.labelCurrency.resignFirstResponder()
        }
    }

    @IBAction func saveTapped(sender: AnyObject) {
        //save
        let cigarette = Cigarette()
        cigarette.id = "1"
        cigarette.quitDate = self.quitDate
        cigarette.smokedPerDay = self.textFieldNumberSmokedPerDay.text.toInt()!
        cigarette.costPerPack = self.textFieldCostPerPack.text.floatValue
        cigarette.cigarettesPerPack = self.textFieldNumberOfCigarettesPerPack.text.toInt()!
        cigarette.currency = self.labelCurrency.text!
        
        let realm = Realm()
        realm.write {
            realm.add(cigarette, update: true)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showQuitDateActionSheet() {

        var datePicker = ActionSheetDatePicker(title: "Choose date", datePickerMode: UIDatePickerMode.DateAndTime, selectedDate: self.quitDate, doneBlock: {
            picker, value, index in
            
            var convertedDate = ""
            
            //downcast AnyObject to NSDate object
            //http://www.codingexplorer.com/type-casting-swift/
            if let dateObject = value as? NSDate {
                convertedDate = ConvertNSDateToString(dateObject, "d MMM yyyy h:mm a")
                self.quitDate = dateObject //set the value of quit date
            }
            self.labelQuitDate.text = convertedDate
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: self.view)
        
        datePicker.showActionSheetPicker()
    }
    
    func showCurrencyActionSheet() {
        var currencyList = ["$", "£", "€", "¥", "₩", "₽", "Rp", "₨", "฿"]
        var chosenIndex = find(currencyList, self.labelCurrency.text!)
        
        ActionSheetStringPicker.showPickerWithTitle("Choose a currency", rows: currencyList, initialSelection: chosenIndex!, doneBlock: {
            picker, value, index in
            
            self.labelCurrency.text = "\(index)"
            
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: self.view)
    }
    
}
