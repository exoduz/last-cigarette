//
//  RJSettingsViewController.swift
//  Last Cigarette
//
//  Created by Robin Roy Julius on 26/05/2015.
//  Copyright (c) 2015 Robin Roy Julius. All rights reserved.
//

import UIKit
import MessageUI
import RealmSwift

class RJSettingsViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let appId: String = Globals.App.kAppId
    let appVersion: String = Globals.App.kVersion
    let appBuild: String = Globals.App.kBuild

    
    var quitDate: String = ""
    var quitTime: String = ""
    
    @IBOutlet weak var labelQuitDate: UILabel!
    @IBOutlet weak var labelQuitTime: UILabel!
    @IBOutlet weak var textFieldNumberSmokedPerDay: UITextField!
    @IBOutlet weak var textFieldCostPerPack: UITextField!
    @IBOutlet weak var textFieldNumberOfCigarettesPerPack: UITextField!
    @IBOutlet weak var labelCurrency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        //get details
        do {
            let realm = try Realm()
            let predicate = NSPredicate(format: "id = %@", "1")
            let cigarette = realm.objects(Cigarette).filter(predicate)
            self.quitDate = ConvertNSDateToString(cigarette[0].quitDate, format: "d MMM yyyy")
            self.quitTime = ConvertNSDateToString(cigarette[0].quitDate, format: "h:mm a")
            
            self.labelQuitDate.text = ConvertNSDateToString(cigarette[0].quitDate, format: "d MMM yyyy")
            self.labelQuitTime.text = ConvertNSDateToString(cigarette[0].quitDate, format: "h:mm a")
            self.textFieldNumberSmokedPerDay.text = "\(cigarette[0].smokedPerDay)"
            self.textFieldCostPerPack.text = "\(cigarette[0].costPerPack)"
            self.textFieldNumberOfCigarettesPerPack.text = "\(cigarette[0].cigarettesPerPack)"
            self.labelCurrency.text = "\(cigarette[0].currency)"
        } catch {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
        self.labelQuitDate.resignFirstResponder()
        self.labelQuitTime.resignFirstResponder()
        self.textFieldNumberSmokedPerDay.resignFirstResponder()
        self.textFieldCostPerPack.resignFirstResponder()
        self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
        self.labelCurrency.resignFirstResponder()
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //respond to cell tap
        if indexPath.section == 0 && indexPath.row == 0 { //date quit
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            showQuitDateActionSheet()
        } else if indexPath.section == 0 && indexPath.row == 1 { //time quit
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            showQuitTimeActionSheet()
        } else if indexPath.section == 0 && indexPath.row == 2 { //number of cigarettes smoked
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldNumberSmokedPerDay.keyboardType = UIKeyboardType.NumberPad
            self.textFieldNumberSmokedPerDay.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 0 { //cost per pack
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldCostPerPack.keyboardType = UIKeyboardType.DecimalPad
            self.textFieldCostPerPack.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 1 { //number of cigarettes per pack
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.keyboardType = UIKeyboardType.NumberPad
            self.textFieldNumberOfCigarettesPerPack.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 2 { //currency
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            showCurrencyActionSheet()
        } else if indexPath.section == 2 && indexPath.row == 0 { //about
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            
            if let url = NSURL(string: "http://robinjulius.com") {
                UIApplication.sharedApplication().openURL(url)
            }
        } else if indexPath.section == 2 && indexPath.row == 1 { //rate on app store
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            
            let url = NSURL(string: "itms-apps://itunes.apple.com/app/id" + appId)
            UIApplication.sharedApplication().openURL(url!);
        } else if indexPath.section == 2 && indexPath.row == 2 { //feedback
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            
            let mailComposer = configureMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposer, animated: true, completion: nil)
            } else {
                self.sendMailError()
            }
        } else {
            self.labelQuitDate.resignFirstResponder()
            self.labelQuitTime.resignFirstResponder()
            self.textFieldNumberSmokedPerDay.resignFirstResponder()
            self.textFieldCostPerPack.resignFirstResponder()
            self.textFieldNumberOfCigarettesPerPack.resignFirstResponder()
            self.labelCurrency.resignFirstResponder()
        }
    }

    @IBAction func saveTapped(sender: AnyObject) {
        //set status bar to light version (NB plist - View controller-based status bar appearance)
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        //save
        let cigarette = Cigarette()
        cigarette.id = "1"
        
        //convert both quit date and time to NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy h:mm a"
        cigarette.quitDate = dateFormatter.dateFromString("\(self.quitDate) \(self.quitTime)")!

        cigarette.smokedPerDay = Int(self.textFieldNumberSmokedPerDay.text!)!
        cigarette.costPerPack = self.textFieldCostPerPack.text!.floatValue
        cigarette.cigarettesPerPack = Int(self.textFieldNumberOfCigarettesPerPack.text!)!
        cigarette.currency = self.labelCurrency.text!
        
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(cigarette, update: true)
            }
        } catch {
            print(error)
        }

        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        //set status bar to light version (NB plist - View controller-based status bar appearance)
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func showQuitDateActionSheet() {
        
        let convertedDate = ConverStringToNSDate(self.quitDate, format: "d MMM yyyy")
        let datePicker = ActionSheetDatePicker(title: "Choose date", datePickerMode: UIDatePickerMode.Date, selectedDate: convertedDate, doneBlock: {
            picker, value, index in
            
            var convertedDate = ""
            
            //downcast AnyObject to NSDate object
            //http://www.codingexplorer.com/type-casting-swift/
            if let dateObject = value as? NSDate {
                convertedDate = ConvertNSDateToString(dateObject, format: "d MMM yyyy")
                self.quitDate = ConvertNSDateToString(dateObject, format: "d MMM yyyy")  //set the value of quit date
            }
            self.labelQuitDate.text = convertedDate
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: self.view)
        
        datePicker.maximumDate = NSDate()
        datePicker.showActionSheetPicker()
    }
    
    func showQuitTimeActionSheet() {
        
        let convertedTime = ConverStringToNSDate(self.quitTime, format: "h:mm a")
        let timePicker = ActionSheetDatePicker(title: "Choose time", datePickerMode: UIDatePickerMode.Time, selectedDate: convertedTime, doneBlock: {
            picker, value, index in
            
            var convertedTime = ""
            
            //downcast AnyObject to NSDate object
            //http://www.codingexplorer.com/type-casting-swift/
            if let timeObject = value as? NSDate {
                convertedTime = ConvertNSDateToString(timeObject, format: "h:mm a")
                self.quitTime = ConvertNSDateToString(timeObject, format: "h:mm a") //set the value of quit time
            }
            self.labelQuitTime.text = convertedTime
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: self.view)
        
        timePicker.showActionSheetPicker()
    }
    
    func showCurrencyActionSheet() {
        let currencyList = ["$", "£", "€", "¥", "₩", "₽", "Rp", "₨", "฿"]
        let chosenIndex = currencyList.indexOf((self.labelCurrency.text!))
        
        ActionSheetStringPicker.showPickerWithTitle("Choose a currency", rows: currencyList, initialSelection: chosenIndex!, doneBlock: {
            picker, value, index in
            
            self.labelCurrency.text = "\(index)"
            
        }, cancelBlock: { ActionStringCancelBlock in return }, origin: self.view)
    }
    
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        
        mail.setToRecipients(["me@robinjulius.com"])
        mail.setSubject("Feedback/bug from Last Cigarette app")
        
        let iOSVersionNumber = Globals.Version.kiOSVersionNumber
        let device = UIDevice.currentDevice().modelName
        let body = "\n\n\n---\niOS Version: \(iOSVersionNumber)\nDevice: \(device)\nApp Version: \(appVersion + " b" + appBuild)"
        mail.setMessageBody(body, isHTML: false)
        
        return mail
    }
    
    func sendMailError() {
        let sendMailErrorAlert = UIAlertView(title: "Could not send email", message: "There was an error sending your email. Please check your email settings and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("Cancelled")
        case MFMailComposeResultSent.rawValue:
            print("Mail Sent")
        default:
            break
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
