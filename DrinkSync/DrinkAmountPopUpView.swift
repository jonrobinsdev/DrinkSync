//
//  DrinkAmountPopUpView.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 4/4/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkAmountPopUpView: UIView, UITextFieldDelegate {

    var settingsDelegate:SettingsDelegate?
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    
    private var currentUnit:String = ""
    var selectedAmount:String = ""
    
    @IBOutlet private var amountTextField: UITextField!
    
    class func instanceFromNib() -> DrinkAmountPopUpView {
        return UINib(nibName: "DrinkAmountPopUpView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! DrinkAmountPopUpView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        amountTextField.delegate = self
        amountTextField.becomeFirstResponder()
        currentUnit = defaults.valueForKey("unit") as! String
    }
    
    @IBAction func leftDefaultButtonPressed(sender: AnyObject) {
        if(currentUnit == "oz"){
            amountTextField.text = "500.0";
        }
        else{
            amountTextField.text = "1000.0";
        }
    }
    
    @IBAction func middleDefaultButtonPressed(sender: AnyObject) {
        if(currentUnit == "oz"){
            amountTextField.text = "2500.0";
        }
        else{
            amountTextField.text = "5000.0";
        }
    }
    
    @IBAction func rightDefaultButtonPressed(sender: AnyObject) {
        if(currentUnit == "oz"){
            amountTextField.text = "10000.0";
        }
        else{
            amountTextField.text = "50000.0";
        }
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        let newAmount = checkValidAmount(Helper.roundFloatToOneDecimal(Float(amountTextField.text!)!))
        defaults.setFloat(newAmount, forKey: selectedAmount)
        settingsDelegate?.setUserDefaults()
        self.removeFromSuperview()
    }
    
    private func checkValidAmount(newAmount:Float) -> Float{
        var newerAmount:Float = newAmount
        
        if(currentUnit == "oz" && selectedAmount == "goalAmount" && newAmount > 300){
            newerAmount = 300;
        }
        else if(currentUnit == "mL" && selectedAmount == "goalAmount" && newAmount > 9000){
            newerAmount = 9000;
        }
        else if(currentUnit == "oz" && selectedAmount != "goalAmount" && newAmount > 100){
            newerAmount = 100;
        }
        else if(currentUnit == "mL" && selectedAmount != "goalAmount" && newAmount > 3000){
            newerAmount = 3000;
        }
        
        return newerAmount
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
    
    //delegate allowing only ONE decimal point in amount field
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool
    {
        let countdots = textField.text!.componentsSeparatedByString(".").count - 1
        
        if countdots > 0 && string == "."
        {
            return false
        }
        return true
    }
}
