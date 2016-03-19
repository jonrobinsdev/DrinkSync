//
//  SettingsViewController.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/18/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var topSpacingConstraint: NSLayoutConstraint!
    
    @IBOutlet var unitSegmentController: UISegmentedControl!
    
    @IBOutlet var goalSlider: UISlider!
    @IBOutlet var leftSlider: UISlider!
    @IBOutlet var middleSlider: UISlider!
    @IBOutlet var rightSlider: UISlider!
    
    @IBOutlet var goalAmountText: UILabel!
    @IBOutlet var leftAmountText: UILabel!
    @IBOutlet var middleAmountText: UILabel!
    @IBOutlet var rightAmountText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.topSpacingConstraint.constant = self.view.frame.height/10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        let segcontrol: UISegmentedControl = sender as! UISegmentedControl
        if(segcontrol.selectedSegmentIndex == 0){
            print("oz")
        }
        else{
            print("ml")
        }
    }
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider;
        switch(slider){
        case goalSlider:
            goalAmountText.text = String(Int(slider.value)) + " oz"
            break;
        case leftSlider:
            leftAmountText.text = String(Int(slider.value)) + " oz"
            break;
        case middleSlider:
            middleAmountText.text = String(Int(slider.value)) + " oz"
            break;
        case rightSlider:
            rightAmountText.text = String(Int(slider.value)) + " oz"
            break;
        default:
            break;
        }
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
