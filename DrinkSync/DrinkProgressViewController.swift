//
//  DrinkProgressViewController.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/15/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkProgressViewController: UIViewController {

    private let defaults = NSUserDefaults.standardUserDefaults()
    private var currentUnit:String = ""
    
    @IBOutlet var drinkProgressView: DrinkProgressView!

    @IBOutlet var leftDrinkButton: UIButton!
    @IBOutlet var middleDrinkButton: UIButton!
    @IBOutlet var rightDrinkButton: UIButton!
    
    @IBOutlet var leftAmountLabel: UILabel!
    @IBOutlet var middleAmountLabel: UILabel!
    @IBOutlet var rightAmountLabel: UILabel!
    
    @IBOutlet var leftUnitLabel: UILabel!
    @IBOutlet var middleUnitLabel: UILabel!
    @IBOutlet var rightUnitLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.drinkProgressView.setAttributes(1.0, percentage: 0.00, unit: "Gallons")
        
        //buttons
        self.leftDrinkButton.layer.cornerRadius = leftDrinkButton.frame.size.width/4
        self.leftDrinkButton.layer.shadowRadius = 3.0
        self.leftDrinkButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.leftDrinkButton.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        self.leftDrinkButton.layer.shadowOpacity = 0.5
        self.middleDrinkButton.layer.cornerRadius = middleDrinkButton.frame.size.width/4
        self.middleDrinkButton.layer.shadowRadius = 3.0
        self.middleDrinkButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.middleDrinkButton.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        self.middleDrinkButton.layer.shadowOpacity = 0.5
        self.rightDrinkButton.layer.cornerRadius = rightDrinkButton.frame.size.width/4
        self.rightDrinkButton.layer.shadowRadius = 3.0
        self.rightDrinkButton.layer.shadowColor = UIColor.blackColor().CGColor
        self.rightDrinkButton.layer.shadowOffset = CGSizeMake(0.0, 1.0)
        self.rightDrinkButton.layer.shadowOpacity = 0.5
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        currentUnit = defaults.valueForKey("unit") as! String
        //amounts
        self.leftAmountLabel.text = String(defaults.floatForKey("leftAmount"))
        self.middleAmountLabel.text = String(defaults.floatForKey("middleAmount"))
        self.rightAmountLabel.text = String(defaults.floatForKey("rightAmount"))
        //units
        self.leftUnitLabel.text = currentUnit
        self.middleUnitLabel.text = currentUnit
        self.rightUnitLabel.text = currentUnit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftDrink(sender: AnyObject){
        let value = getPercentageOfWaterToAdd(defaults.floatForKey("leftAmount"))
        self.drinkProgressView.addWater(value)
    }
    
    @IBAction func middleDrink(sender: AnyObject){
        let value = getPercentageOfWaterToAdd(defaults.floatForKey("middleAmount"))
        self.drinkProgressView.addWater(value)
    }
    
    @IBAction func rightDrink(sender: AnyObject){
        let value = getPercentageOfWaterToAdd(defaults.floatForKey("rightAmount"))
        self.drinkProgressView.addWater(value)
    }
    
    func getPercentageOfWaterToAdd(addedWaterAmount:Float) -> CGFloat{
        let percentToFill = CGFloat(addedWaterAmount)/CGFloat(defaults.floatForKey("goalAmount"))
        return percentToFill
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
