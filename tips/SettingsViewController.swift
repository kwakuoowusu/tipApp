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
        //let stringValue = defaults.objectForKey("loadString") as! String
        if let defaultIndex = defaults.objectForKey("loadInt"){
            
                defaultTipSegmentedControl.selectedSegmentIndex = defaultIndex as! Int
        }
        else{
            defaultTipSegmentedControl.selectedSegmentIndex = 0
            
        }
        
        
        
        //on loading make default tip percentage equal saved index
        //defaultTipSegmentedControl.selectedSegmentIndex  = defaultIndex
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSegmentedControl.selectedSegmentIndex,forKey: "loadInt")
        defaults.synchronize()
        print("saved")
    }
    
    @IBAction func onBackPressed(sender: UIBarButtonItem) {
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
