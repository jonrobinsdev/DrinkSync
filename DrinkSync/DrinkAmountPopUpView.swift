//
//  DrinkAmountPopUpView.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 4/4/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkAmountPopUpView: UIView {

    @IBOutlet private var amountTextField: UITextField!
    
    class func instanceFromNib() -> DrinkAmountPopUpView {
        return UINib(nibName: "DrinkAmountPopUpView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DrinkAmountPopUpView
    }
    
    @IBAction func leftDefaultButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func middleDefaultButtonPressed(sender: AnyObject) {
        
    }
    @IBAction func rightDefaultButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.removeFromSuperview()
    }
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.removeFromSuperview()
    }
    
    func setAmount(value:Float){
        self.amountTextField.text = String(value)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
