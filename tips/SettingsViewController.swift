//
//  SettingsViewController.swift
//  tips
//
//  Created by Kwaku Owusu on 12/2/15.
//  Copyright © 2015 Kwaku Owusu. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        //gets array index of segment controller and makes it default
        if let defaultIndex = defaults.objectForKey("loadInt"){
            
                defaultTipSegmentedControl.selectedSegmentIndex = defaultIndex as! Int
        }
        else{
            defaultTipSegmentedControl.selectedSegmentIndex = 0
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when default is changed it is saved into NSUserDefaultts
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSegmentedControl.selectedSegmentIndex,forKey: "loadInt")
        defaults.synchronize()
    }
    
    //when back button pressed get sent back to main view controller
    @IBAction func onBackPressed(sender: UIBarButtonItem) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    

}
