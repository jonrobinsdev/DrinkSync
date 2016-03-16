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
        let waterDropView:UIView = UIView(frame: CGRect(x: 0, y: -150, width: 50, height: 70))

        CATransaction.begin()
        CATransaction.setCompletionBlock({
            waterDropView.removeFromSuperview()
            
            //cup shake animation
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.20
            animation.repeatCount = 1
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(self.drinkProgressView.center.x, self.drinkProgressView.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(self.drinkProgressView.center.x, self.drinkProgressView.center.y + 12))
            self.drinkProgressView.layer.addAnimation(animation, forKey: "position")
            
            let newPercentage = self.drinkProgressView.currentPercentage + CGFloat(0.05)
            self.drinkProgressView.setAttributes(120.0, currentPercentage: newPercentage, unit: "Gallons")
            let currentPercentage = self.drinkProgressView.currentPercentage * 100
            self.percentLabel.text = String(format: "%.0f", currentPercentage) + "%"
        })

        //water drop animation
        waterDropView.backgroundColor = UIColor.blueColor()
        drinkProgressView.addSubview(waterDropView)
        waterDropView.center.x = waterDropView.superview!.center.x
        let dropAnimation = CABasicAnimation(keyPath: "position")
        dropAnimation.duration = 0.70
        dropAnimation.fromValue = NSValue(CGPoint: CGPointMake(waterDropView.center.x, waterDropView.center.y))
        dropAnimation.toValue = NSValue(CGPoint: CGPointMake(waterDropView.center.x, drinkProgressView.frame.size.height - drinkProgressView.frame.size.height/2))
        waterDropView.layer.addAnimation(dropAnimation, forKey: "position")

        CATransaction.commit()
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
