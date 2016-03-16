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
    @IBOutlet var percentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drinkProgressView.setAttributes(120.0, currentPercentage: 0.00, unit: "Gallons")
        let currentPercentage = drinkProgressView.currentPercentage * 100
        self.percentLabel.text = String(format: "%.0f", currentPercentage) + "%"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button(sender: AnyObject) {
        let newPercentage = drinkProgressView.currentPercentage + CGFloat(0.10)
        self.drinkProgressView.setAttributes(120.0, currentPercentage: newPercentage, unit: "Gallons")
        let currentPercentage = drinkProgressView.currentPercentage * 100
        self.percentLabel.text = String(format: "%.0f", currentPercentage) + "%"
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
