//
//  SettingsViewController.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/18/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    private var currentUnit:String = ""
    
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
        self.topSpacingConstraint.constant = 15
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true);
        setUserDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func segmentedControlChanged(sender: AnyObject) {
        let segcontrol: UISegmentedControl = sender as! UISegmentedControl
        if(segcontrol.selectedSegmentIndex == 0){
            defaults.setValue("oz", forKey: "unit")
            setUserDefaults()
        }
        else{
            defaults.setValue("ml", forKey: "unit")
            setUserDefaults()
        }
    }
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        let slider:UISlider = sender as! UISlider
        switch(slider){
        case goalSlider:
            goalAmountText.text = String(Helper.roundFloatToOneDecimal(slider.value)) + " " + currentUnit
            defaults.setFloat(Helper.roundFloatToOneDecimal(slider.value), forKey: "goalAmount")
            break;
        case leftSlider:
            leftAmountText.text = String(Helper.roundFloatToOneDecimal(slider.value)) + " " + currentUnit
            defaults.setFloat(Helper.roundFloatToOneDecimal(slider.value), forKey: "leftAmount")
            break;
        case middleSlider:
            middleAmountText.text = String(Helper.roundFloatToOneDecimal(slider.value)) + " " + currentUnit

            defaults.setFloat(Helper.roundFloatToOneDecimal(slider.value), forKey: "middleAmount")
            break;
        case rightSlider:
            rightAmountText.text = String(Helper.roundFloatToOneDecimal(slider.value)) + " " + currentUnit

            defaults.setFloat(Helper.roundFloatToOneDecimal(slider.value), forKey: "rightAmount")
            break;
        default:
            break;
        }
    }
    
    func setUserDefaults(){
        currentUnit = defaults.valueForKey("unit") as! String
        
        goalSlider.value = defaults.floatForKey("goalAmount")
        goalAmountText.text = String(defaults.floatForKey("goalAmount")) + " " + currentUnit

        leftSlider.value = defaults.floatForKey("leftAmount")
        leftAmountText.text = String(defaults.floatForKey("leftAmount")) + " " + currentUnit

        middleSlider.value = defaults.floatForKey("middleAmount")
        middleAmountText.text = String(defaults.floatForKey("middleAmount")) + " " + currentUnit

        rightSlider.value = defaults.floatForKey("rightAmount")
        rightAmountText.text = String(defaults.floatForKey("rightAmount")) + " " + currentUnit
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
