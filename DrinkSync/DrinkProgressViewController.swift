//
//  DrinkProgressViewController.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/15/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkProgressViewController: UIViewController {

    @IBOutlet var drinkProgressView: DrinkProgressView!

    @IBOutlet var leftDrinkButton: UIButton!
    @IBOutlet var middleDrinkButton: UIButton!
    @IBOutlet var rightDrinkButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.drinkProgressView.setAttributes(2.0, percentage: 0.00, unit: "Gallons")
        self.leftDrinkButton.layer.cornerRadius = leftDrinkButton.frame.size.width/2
        self.middleDrinkButton.layer.cornerRadius = middleDrinkButton.frame.size.width/2
        self.rightDrinkButton.layer.cornerRadius = rightDrinkButton.frame.size.width/2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func leftDrink(sender: AnyObject){
        self.drinkProgressView.addWater(0.05)
    }
    
    @IBAction func middleDrink(sender: AnyObject){
        self.drinkProgressView.addWater(0.10)
    }
    
    @IBAction func rightDrink(sender: AnyObject){
        self.drinkProgressView.addWater(0.20)
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
