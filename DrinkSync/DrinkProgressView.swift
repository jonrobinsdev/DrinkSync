//
//  DrinkProgressView.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/11/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkProgressView: UIView {
    
    var percentLabel: UILabel!
    private let lineWidth: CGFloat = 2
    private let pi = M_PI
    private var goalAmount: CGFloat = 0.0
    private var currentPercentage: CGFloat = 0.0
    private var unit = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.percentLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    }
    
    override func drawRect(rect: CGRect) {
        
        //percent label
        let labelPercentage = self.currentPercentage * 100
        percentLabel.text = String(format: "%.0f", labelPercentage) + "%"
        percentLabel.font = UIFont(name: "Avenir-Light", size: 26.0)
        percentLabel.textAlignment = .Center
        percentLabel.removeFromSuperview()
        self.addSubview(percentLabel)
        percentLabel.center.x = percentLabel.superview!.center.x
        percentLabel.center.y = percentLabel.superview!.center.y
        
        //path drawings
        drawCup()
        setWaterLevel()
    }
    
    func setAttributes(goalAmount: CGFloat, var currentPercentage: CGFloat, unit: String){
        if currentPercentage >= 1.0 { currentPercentage = 1.0 }
        self.goalAmount = goalAmount
        self.currentPercentage = currentPercentage
        self.unit = unit
        self.setNeedsDisplay()
    }
    
    func drawCup(){
        UIColor.grayColor().setStroke()
        
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
        path2.lineWidth = lineWidth
        path1.appendPath(path2)
        path1.stroke()
    }
    
    func setWaterLevel(){
        var path3 = UIBezierPath()
        let path4 = UIBezierPath()
        
        let waterBlueColor:UIColor = UIColor.init(colorLiteralRed: 28.0/255.0, green: 163.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        waterBlueColor.setFill()
        //UIColor.blueColor().setFill()
        
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
        let finalTopWaterHeight = (bounds.height/1.5 + 2) - z
        
        var bottomWaterPercent: CGFloat = 0.0
        if(currentPercentage > bottomWaterPercentAmount){
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
            
            path4.lineWidth = lineWidth
            path4.closePath()
            path4.fill()
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
        path3.lineWidth = lineWidth
        path3.fill()
    }
    
    func addWater(value:CGFloat){
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
            self.layer.addAnimation(animation, forKey: "position")
            
            //incrementing cup
            let newPercentage = self.currentPercentage + value
            self.setAttributes(self.goalAmount, currentPercentage: newPercentage, unit: "Gallons")
            let currentPercentage = self.currentPercentage * 100
            self.percentLabel.text = String(format: "%.0f", currentPercentage) + "%"
        })
        
        //water drop animation
        let dropAnimation = CABasicAnimation(keyPath: "position")
        dropAnimation.duration = 0.70
        dropAnimation.fromValue = NSValue(CGPoint: CGPointMake(waterDropView.center.x, waterDropView.center.y))
        dropAnimation.toValue = NSValue(CGPoint: CGPointMake(waterDropView.center.x, self.frame.size.height - self.frame.size.height/3))
        waterDropView.layer.addAnimation(dropAnimation, forKey: "position")
        
        CATransaction.commit()
    }
}
