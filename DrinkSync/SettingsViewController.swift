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
    
    @IBOutlet private var topSpacingConstraint: NSLayoutConstraint!
    
    @IBOutlet private var unitSegmentController: UISegmentedControl!
    
    @IBOutlet private var goalSlider: UISlider!
    @IBOutlet private var leftSlider: UISlider!
    @IBOutlet private var middleSlider: UISlider!
    @IBOutlet private var rightSlider: UISlider!
    
    @IBOutlet private var goalAmountText: UILabel!
    @IBOutlet private var leftAmountText: UILabel!
    @IBOutlet private var middleAmountText: UILabel!
    @IBOutlet private var rightAmountText: UILabel!

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
            
            var newValue = goalSlider.value/29.5735
            goalSlider.minimumValue = 10
            goalSlider.maximumValue = 300
            goalSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(goalSlider.value), forKey: "goalAmount")
            
            newValue = leftSlider.value/29.5735
            leftSlider.minimumValue = 1
            leftSlider.maximumValue = 100
            leftSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(leftSlider.value), forKey: "leftAmount")
            
            newValue = middleSlider.value/29.5735
            middleSlider.minimumValue = 1
            middleSlider.maximumValue = 100
            middleSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(middleSlider.value), forKey: "middleAmount")

            newValue = rightSlider.value/29.5735
            rightSlider.minimumValue = 1
            rightSlider.maximumValue = 100
            rightSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(rightSlider.value), forKey: "rightAmount")
            
            setUserDefaults()
        }
        else{
            defaults.setValue("mL", forKey: "unit")
            
            var newValue = goalSlider.value*29.5735
            goalSlider.minimumValue = 100
            goalSlider.maximumValue = 9000
            goalSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(goalSlider.value), forKey: "goalAmount")
            
            newValue = leftSlider.value*29.5735
            leftSlider.minimumValue = 10
            leftSlider.maximumValue = 3000
            leftSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(leftSlider.value), forKey: "leftAmount")
            
            newValue = middleSlider.value*29.5735
            middleSlider.minimumValue = 10
            middleSlider.maximumValue = 3000
            middleSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(middleSlider.value), forKey: "middleAmount")
            
            newValue = rightSlider.value*29.5735
            rightSlider.minimumValue = 10
            rightSlider.maximumValue = 3000
            rightSlider.value = newValue
            defaults.setFloat(Helper.roundFloatToOneDecimal(rightSlider.value), forKey: "rightAmount")

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
        if(currentUnit == "oz"){
            unitSegmentController.selectedSegmentIndex = 0
        }
        else{
            unitSegmentController.selectedSegmentIndex = 1
            goalSlider.minimumValue = 100
            goalSlider.maximumValue = 9000
            leftSlider.minimumValue = 10
            leftSlider.maximumValue = 3000
            middleSlider.minimumValue = 10
            middleSlider.maximumValue = 3000
            rightSlider.minimumValue = 10
            rightSlider.maximumValue = 3000
        }
        
        goalSlider.value = defaults.floatForKey("goalAmount")
        goalAmountText.text = String(defaults.floatForKey("goalAmount")) + " " + currentUnit

        leftSlider.value = defaults.floatForKey("leftAmount")
        leftAmountText.text = String(defaults.floatForKey("leftAmount")) + " " + currentUnit

        middleSlider.value = defaults.floatForKey("middleAmount")
        middleAmountText.text = String(defaults.floatForKey("middleAmount")) + " " + currentUnit

        rightSlider.value = defaults.floatForKey("rightAmount")
        rightAmountText.text = String(defaults.floatForKey("rightAmount")) + " " + currentUnit
    }

    
    @IBAction func goalAmountButtonPressed(sender: AnyObject) {
        let popUpView:DrinkAmountPopUpView = self.getPopUpView()
        popUpView.setAmount(defaults.floatForKey("goalAmount"))
        self.view.addSubview(popUpView)
        popUpView.layer.addAnimation(getPopUpViewAnimation(popUpView), forKey: "position")
    }
    
    @IBAction func leftAmountButtonPressed(sender: AnyObject) {
        let popUpView:DrinkAmountPopUpView = self.getPopUpView()
        popUpView.setAmount(defaults.floatForKey("leftAmount"))
        self.view.addSubview(popUpView)
        popUpView.layer.addAnimation(getPopUpViewAnimation(popUpView), forKey: "position")
    }
    @IBAction func middleAmountButtonPressed(sender: AnyObject) {
        let popUpView:DrinkAmountPopUpView = self.getPopUpView()
        popUpView.setAmount(defaults.floatForKey("middleAmount"))
        self.view.addSubview(popUpView)
        popUpView.layer.addAnimation(getPopUpViewAnimation(popUpView), forKey: "position")
    }
    @IBAction func rightAmountButtonPressed(sender: AnyObject) {
        let popUpView:DrinkAmountPopUpView = self.getPopUpView()
        popUpView.setAmount(defaults.floatForKey("rightAmount"))
        self.view.addSubview(popUpView)
        popUpView.layer.addAnimation(getPopUpViewAnimation(popUpView), forKey: "position")
    }
    
    private func getPopUpView() -> DrinkAmountPopUpView{
        let frame:CGRect = CGRectMake(0, self.view.frame.size.height/4.5, self.view.frame.size.width, self.view.frame.size.height/2.5)
        let popUpView: DrinkAmountPopUpView = DrinkAmountPopUpView.instanceFromNib()
        popUpView.frame = frame
        return popUpView
    }
    
    private func getPopUpViewAnimation(popUpView:UIView) -> CABasicAnimation{
        let slideInAnimation = CABasicAnimation(keyPath: "position")
        slideInAnimation.duration = 0.50
        slideInAnimation.fromValue = NSValue(CGPoint: CGPointMake(popUpView.center.x+600, popUpView.center.y))
        slideInAnimation.toValue = NSValue(CGPoint: CGPointMake(popUpView.center.x, popUpView.center.y))
        return slideInAnimation
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
