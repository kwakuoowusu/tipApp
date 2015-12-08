//
//  TipViewController.swift
//  tips
//
//  Created by Kwaku Owusu on 12/1/15.
//  Copyright © 2015 Kwaku Owusu. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {

    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        //load up user prefrences
        let defaults = NSUserDefaults.standardUserDefaults()

        if let defaultIndex = defaults.objectForKey("loadInt"){
            
            tipControl.selectedSegmentIndex = defaultIndex as! Int
        }
        else{
            tipControl.selectedSegmentIndex = 0
            
        }
        
        //check to see if ten minutes has passed
        //if ten minutes has expired the dfault bill value becomes 0
        //else it will be loaded up from defaults
        if let storedTime = defaults.objectForKey("loadtime"){
            let loadedMinutes = storedTime as! Int
            
            let timeAtLoad = NSDate()
            
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(NSCalendarUnit.Year.union(NSCalendarUnit.Minute),fromDate: timeAtLoad)
            
            let currentMinutes = components.minute
            
           
            if (loadedMinutes <= 50&&currentMinutes - loadedMinutes < 10){
                print("less 50")
                print (loadedMinutes)
                if (currentMinutes > loadedMinutes + 10){
                    billField.text = ""
                }
                else{
                    //load up all values in place them into appropriate fields
                    billField.text = defaults.objectForKey("loadbill") as? String
                    tipLabel.text = defaults.objectForKey("loadtip") as? String
                    totalLabel.text = defaults.objectForKey("loadtotal") as? String
                    onEditingChanged(billField)
                }
                
            }
                
            //figure out how to account for 10 minutes past the hours
            /*else if(loadedMinutes>50){
                if(if currentMinutes)
            }
            */
        }
        //make keyboard pup up upon entering app
        self.billField.becomeFirstResponder()
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //if billfield is empty make the labels fade
        if(NSString(string:billField.text!).doubleValue == 0){
            
        
        self.totalLabel.alpha = 0
        self.tipControl.alpha = 0
        }
        
        //load up user prefs
        let defaults = NSUserDefaults.standardUserDefaults()
       
        if let defaultIndex = defaults.objectForKey("loadInt"){
            
            tipControl.selectedSegmentIndex = defaultIndex as! Int
        }
        else{
            tipControl.selectedSegmentIndex = 0
            
        }
        self.billField.becomeFirstResponder()
    }
    
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
    UIView.animateWithDuration(0.4, animations: {
        //makes labels appear
            self.totalLabel.alpha = 1
            self.tipControl.alpha = 1
        })
        
    let defaults = NSUserDefaults.standardUserDefaults()
        //save the time at which the bill was entered

    if billField.text != ""{
        let timeAtPress = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.Year.union(NSCalendarUnit.Minute),fromDate: timeAtPress)
        let minutes = components.minute
        defaults.setObject(minutes,forKey:"loadtime")
        defaults.setObject(NSString(string:billField.text!),forKey:"loadbill")
        defaults.synchronize()

        }
    
   
    var tipPercentages = [0.18,0.2,0.22]
    let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
    
    let billAmount = NSString(string:billField.text!).doubleValue
  

   
    let tip = billAmount * tipPercentage

    let total = billAmount + tip
    
    tipLabel.text = "\(tip)"
    totalLabel.text = "\(total)"
        
    tipLabel.text = String(format: "$%.2f", tip)
    totalLabel.text = String(format: "$%.2f", total)
    
        //save bill amounts to display later when view loaded
    defaults.setObject(NSString(string:tipLabel.text!).doubleValue,forKey: "loadtip")
    defaults.setObject(NSString(string:totalLabel.text!).doubleValue,forKey:"loadtotal")
    defaults.synchronize()
        
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

