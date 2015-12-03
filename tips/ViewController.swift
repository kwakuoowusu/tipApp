//
//  ViewController.swift
//  tips
//
//  Created by Kwaku Owusu on 12/1/15.
//  Copyright © 2015 Kwaku Owusu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        let defaults = NSUserDefaults.standardUserDefaults()

        if let defaultIndex = defaults.objectForKey("loadInt"){
            
            tipControl.selectedSegmentIndex = defaultIndex as! Int
        }
        else{
            tipControl.selectedSegmentIndex = 0
            
        }

        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if(NSString(string:billField.text!).doubleValue == 0){
            
        
        self.totalLabel.alpha = 0
        self.tipControl.alpha = 0
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
       
        if let defaultIndex = defaults.objectForKey("loadInt"){
            
            tipControl.selectedSegmentIndex = defaultIndex as! Int
        }
        else{
            tipControl.selectedSegmentIndex = 0
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        
        UIView.animateWithDuration(0.4, animations: {
            // This causes first view to fade in and second view to fade out
            self.totalLabel.alpha = 1
            self.tipControl.alpha = 1
        })
    var tipPercentages = [0.18,0.2,0.22]
    let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
    
    let billAmount = NSString(string:billField.text!).doubleValue
    let tip = billAmount * tipPercentage
    let total = billAmount + tip
    
    tipLabel.text = "\(tip)"
    totalLabel.text = "\(total)"
        
    tipLabel.text = String(format: "$%.2f", tip)
    totalLabel.text = String(format: "$%.2f", tip)

    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

