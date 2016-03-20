//
//  DrinkProgressView.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/11/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkProgressView: UIView {
    
    private var cupView: UIView!
    private var cupViewLayer1: CAShapeLayer = CAShapeLayer()
    private var cupViewLayer2: CAShapeLayer = CAShapeLayer()
    private var cupViewLayer3: CAShapeLayer = CAShapeLayer()
    private var cupViewLayer4: CAShapeLayer = CAShapeLayer()
    private var percentLabel: UILabel!
    private var resetButton: UIButton!
    
    private let lineWidth: CGFloat = 2
    private let pi = M_PI
    private var goalAmount: CGFloat = 0.0
    private var currentPercentage: CGFloat = 0.0
    private var unit = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        
        //foreground view
        if(cupView == nil){
            cupView = UIView(frame: self.frame)
            self.addSubview(cupView)
        }
        
        //reset button
        if(self.resetButton == nil){
            resetButton = UIButton(type: UIButtonType.Custom) as UIButton
            resetButton.frame = CGRectMake(20, 10, 30, 30)
            resetButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
            resetButton.setBackgroundImage(UIImage(named: "reseticon.png"), forState: UIControlState.Normal)
            resetButton.addTarget(self, action:"resetDrinkProgressView", forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(resetButton)
            resetButton.center.y = resetButton.superview!.frame.size.height - resetButton.superview!.frame.size.height/12
            resetButton.hidden = true
        }
        
        //percent label
        if(self.percentLabel == nil){
            percentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
            percentLabel.font = UIFont(name: "Menlo", size: 35.0)
            percentLabel.textColor = UIColor.init(colorLiteralRed: 86.0/255.0, green: 102.0/255.0, blue: 108.0/255.0, alpha: 1.0)
            percentLabel.textAlignment = .Center
            self.addSubview(percentLabel)
            percentLabel.center.x = percentLabel.superview!.center.x
            percentLabel.center.y = percentLabel.superview!.center.y
        }
        let labelPercentage = self.currentPercentage * 100
        percentLabel.text = String(format: "%.0f", labelPercentage) + "%"
        
        //path drawings
        drawCup()
        setWaterLevel()
    }
    
    func setAttributes(goalAmount: CGFloat, percentage: CGFloat, unit: String){
        self.goalAmount = goalAmount
        self.currentPercentage = percentage
        self.unit = unit
        self.setNeedsDisplay()
    }
    
    func drawCup(){
        //sides
        let path1 = UIBezierPath()
        path1.lineWidth = lineWidth
        
        path1.moveToPoint(CGPoint(
            x:bounds.width/2 - bounds.width/3.5,
            y:bounds.height/6
            ))
        path1.addLineToPoint(CGPoint(
            x:bounds.width/2 - bounds.width/3.5,
            y:bounds.height/1.5
            ))
        path1.moveToPoint(CGPoint(
            x:bounds.width/2 + bounds.width/3.5,
            y:bounds.height/6
            ))
        path1.addLineToPoint(CGPoint(
            x:bounds.width/2 + bounds.width/3.5,
            y:bounds.height/1.5
            ))
        
        //bowl
        let center = CGPoint(x:bounds.width/2, y: (bounds.height/1.5))
        let radius: CGFloat = bounds.width - (bounds.width/2 - (bounds.width/3.5)) - (bounds.width/2 - (bounds.width/3.5)) + 1.5
        let startAngle: CGFloat = 0.0
        let endAngle: CGFloat = CGFloat(pi)
        let path2 = UIBezierPath(arcCenter: center,
            radius: radius/2 - 2.0/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        //cupView layers
        cupViewLayer1.path = path1.CGPath
        cupViewLayer1.lineWidth = lineWidth
        cupViewLayer1.strokeColor = UIColor.grayColor().CGColor
        cupViewLayer2.path = path2.CGPath
        cupViewLayer2.lineWidth = lineWidth
        cupViewLayer2.strokeColor = UIColor.grayColor().CGColor
        cupViewLayer2.fillColor = nil
        self.cupView.layer.addSublayer(cupViewLayer1)
        self.cupView.layer.addSublayer(cupViewLayer2)
    }
    
    func setWaterLevel(){
        var path3 = UIBezierPath()
        let path4 = UIBezierPath()
        
        let waterBlueColor:UIColor = UIColor.init(colorLiteralRed: 99.0/255.0, green: 192.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
        let center = CGPoint(x:bounds.width/2, y: (bounds.height/1.5))
        let waterRadius: CGFloat = bounds.width - (bounds.width/2 - (bounds.width/3.5)) - (bounds.width/2 - (bounds.width/3.5)) - 7.5
        let totalHeight = (((bounds.height/1.5 + 2) - bounds.height/6) + (waterRadius/2 - 2.0/2))
        let topHeight = ((bounds.height/1.5 + 2) - bounds.height/6)
        let bottomHeight = (waterRadius/2 - 2.0/2)
        let topWaterPercentAmount = topHeight / totalHeight
        let bottomWaterPercentAmount = bottomHeight / totalHeight

        //to calculate height of top water level
        let x = currentPercentage - bottomWaterPercentAmount;
        let y = x / topWaterPercentAmount
        let z = y * topHeight
        var finalTopWaterHeight = (bounds.height/1.5 + 2) - z
        var bottomWaterPercent: CGFloat = 0.0
        if(currentPercentage > bottomWaterPercentAmount){
            //check that it's at 100% or not
            if currentPercentage >= 1.0 { finalTopWaterHeight = bounds.height/6 }
            path4.moveToPoint(CGPoint(
            x:bounds.width/2 - (bounds.width/3.5 - 4.5),
            y:finalTopWaterHeight
            ))
            path4.addLineToPoint(CGPoint(
            x:bounds.width/2 - (bounds.width/3.5 - 4.5),
            y:bounds.height/1.5 + 4
            ))
            path4.addLineToPoint(CGPoint(
            x:bounds.width/2 + (bounds.width/3.5 - 4.5),
            y:bounds.height/1.5 + 4
            ))
            path4.addLineToPoint(CGPoint(
            x:bounds.width/2 + (bounds.width/3.5 - 4.5),
            y:finalTopWaterHeight
            ))
            path4.closePath()
        }
        else{
            bottomWaterPercent = 1 - (currentPercentage / bottomWaterPercentAmount)
        }

        //to calculate height of bottom water level
        let calculation: CGFloat = bottomWaterPercent * 90
        let radiansToAdd: CGFloat = calculation * CGFloat((pi/180))
        let startAngle: CGFloat = -CGFloat(CGFloat(pi) + radiansToAdd)
        let endAngle: CGFloat = -CGFloat(0 - radiansToAdd)
        path3 = UIBezierPath(arcCenter: center,
            radius: waterRadius/2 - 2.0/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false)
        
        //cupView layers
        cupViewLayer3.path = path3.CGPath
        cupViewLayer3.lineWidth = lineWidth
        if currentPercentage == 0.0 { cupViewLayer3.fillColor = UIColor.clearColor().CGColor
        } else { cupViewLayer3.fillColor = waterBlueColor.CGColor}
        cupViewLayer4.path = path4.CGPath
        cupViewLayer4.lineWidth = lineWidth
        cupViewLayer4.fillColor = waterBlueColor.CGColor
        self.cupView.layer.addSublayer(cupViewLayer3)
        self.cupView.layer.addSublayer(cupViewLayer4)
    }
    
    func addWater(value:CGFloat){
        self.resetButton.enabled = false
        
        var dropSize:Int = 0
        if(value/goalAmount <= 0.05){
            dropSize = 40 }
        else if(value/goalAmount > 0.05 && value/goalAmount <= 0.10){
            dropSize = 50 }
        else{
            dropSize = 60 }
        let waterDropView:UIView = UIView(frame: CGRect(x: 0, y: -150, width: dropSize, height: dropSize))
        waterDropView.backgroundColor = UIColor.init(colorLiteralRed: 16.0/255.0, green: 133.0/255.0, blue: 296.0/255.0, alpha: 1.0)
        waterDropView.layer.cornerRadius = waterDropView.frame.size.width/2
        self.addSubview(waterDropView)
        waterDropView.center.x = waterDropView.superview!.center.x
        
        CATransaction.begin()
        //callback for water drop animation
        CATransaction.setCompletionBlock({
            waterDropView.removeFromSuperview()
            
            //cup shake animation
            let animation = CABasicAnimation(keyPath: "position")
            animation.duration = 0.20
            animation.repeatCount = 1
            animation.autoreverses = true
            animation.fromValue = NSValue(CGPoint: CGPointMake(self.center.x, self.center.y))
            animation.toValue = NSValue(CGPoint: CGPointMake(self.center.x, self.center.y + 12))
            self.percentLabel.layer.addAnimation(animation, forKey: "position")
            self.cupView.layer.addAnimation(animation, forKey: "position")
            
            //incrementing cup and changing current percent
            let newPercentage = (self.currentPercentage * self.goalAmount) + value
            self.currentPercentage = newPercentage/self.goalAmount
            self.setNeedsDisplay()
            let percentLabelTextValue = self.currentPercentage * 100
            self.percentLabel.text = String(format: "%.0f", percentLabelTextValue) + "%"
            
            self.resetButton.hidden = false
            self.resetButton.enabled = true
            self.checkGoalIsMet()
        })
        
        //water drop animation
        let dropAnimation = CABasicAnimation(keyPath: "position")
        dropAnimation.duration = 0.70
        dropAnimation.fromValue = NSValue(CGPoint: CGPointMake(waterDropView.center.x, waterDropView.center.y))
        dropAnimation.toValue = NSValue(CGPoint: CGPointMake(waterDropView.center.x, self.frame.size.height - self.frame.size.height/3))
        waterDropView.layer.addAnimation(dropAnimation, forKey: "position")
        
        CATransaction.commit()
    }
    
    func checkGoalIsMet(){
        if(self.currentPercentage >= 1.0){
            goalCompleted()
        } //had to add in because CGFloat for some reason doesn't round all the way
        else if((self.currentPercentage + 0.001) >= 1.0){
            goalCompleted()
        }
    }
    
    func goalCompleted(){
        //add animation here for goal complete
    }
    
    func resetDrinkProgressView(){
        self.resetButton.hidden = true
        self.setAttributes(self.goalAmount, percentage: 0.0, unit: self.unit)
    }
}
