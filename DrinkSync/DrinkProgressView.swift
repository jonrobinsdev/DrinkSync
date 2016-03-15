//
//  DrinkProgressView.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/11/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkProgressView: UIView {
    private let lineWidth: CGFloat = 2
    private let pi = M_PI
    let currentPercentage: CGFloat = 0.15
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.grayColor().setStroke()
        
        //sides
        let path = UIBezierPath()
        path.lineWidth = lineWidth
        
        path.moveToPoint(CGPoint(
            x:bounds.width/2 - bounds.width/3.5,
            y:bounds.height/6
        ))
        path.addLineToPoint(CGPoint(
            x:bounds.width/2 - bounds.width/3.5,
            y:bounds.height/1.5
        ))
        path.moveToPoint(CGPoint(
            x:bounds.width/2 + bounds.width/3.5,
            y:bounds.height/6
        ))
        path.addLineToPoint(CGPoint(
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
        path.appendPath(path2)
        path.stroke()
        
        setWaterLevel();
    }
    
    func setWaterLevel(){
        UIColor.blueColor().setFill()
        let center = CGPoint(x:bounds.width/2, y: (bounds.height/1.5))
        let waterRadius: CGFloat = bounds.width - (bounds.width/2 - (bounds.width/3.5)) - (bounds.width/2 - (bounds.width/3.5)) - 7.5
        let totalHeight = (((bounds.height/1.5 + 2) - bounds.height/6) + (waterRadius/2 - 2.0/2))
        let topHeight = ((bounds.height/1.5 + 2) - bounds.height/6)
        let bottomHeight = (waterRadius/2 - 2.0/2)
        
        let topWaterPercentAmount = topHeight / totalHeight
        let bottomWaterPercentAmount = bottomHeight / totalHeight

        let topFilledPercent = totalHeight
        
        print(bottomWaterPercentAmount)
        print(topWaterPercentAmount)
        print((bounds.height/6) * topFilledPercent)
        
        //top water
        var bottomWaterPercent: CGFloat = 0.0
        if(currentPercentage > bottomWaterPercentAmount){
            let path4 = UIBezierPath()
            
            path4.moveToPoint(CGPoint(
            x:bounds.width/2 - (bounds.width/3.5 - 4.5),
            y:bounds.height/6
            ))
            path4.addLineToPoint(CGPoint(
            x:bounds.width/2 - (bounds.width/3.5 - 4.5),
            y:bounds.height/1.5 + 2
            ))
            path4.addLineToPoint(CGPoint(
            x:bounds.width/2 + (bounds.width/3.5 - 4.5),
            y:bounds.height/1.5 + 2
            ))
            path4.addLineToPoint(CGPoint(
            x:bounds.width/2 + (bounds.width/3.5 - 4.5),
            y:bounds.height/6
            ))
            
            path4.lineWidth = lineWidth
            path4.closePath()
            path4.fill()
        }
        else{
            bottomWaterPercent = 1 - (currentPercentage / bottomWaterPercentAmount)
        }

        //bottom water
        let calculation: CGFloat = bottomWaterPercent * 90
        let radiansToAdd: CGFloat = calculation * CGFloat((pi/180))
        
        let startAngle: CGFloat = -CGFloat(CGFloat(pi) + radiansToAdd)
        let endAngle: CGFloat = -CGFloat(0 - radiansToAdd)
        let path3 = UIBezierPath(arcCenter: center,
            radius: waterRadius/2 - 2.0/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false)
        path3.lineWidth = lineWidth
        path3.fill()
    }
}
