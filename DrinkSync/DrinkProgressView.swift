//
//  DrinkProgressView.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/11/16.
//  Copyright © 2016 robins. All rights reserved.
//

import UIKit

class DrinkProgressView: UIView {
    let lineWidth: CGFloat = 3

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.grayColor().setStroke()
        
        //sides
        let path = UIBezierPath()
        path.lineWidth = 2
        path.moveToPoint(CGPoint(
            x:bounds.width/2 - 100,
            y:bounds.height/6))
        path.addLineToPoint(CGPoint(
            x:bounds.width/2 - 100,
            y:bounds.height/1.5))
        path.moveToPoint(CGPoint(
            x:bounds.width/2 + 100,
            y:bounds.height/6))
        path.addLineToPoint(CGPoint(
            x:bounds.width/2 + 100,
            y:bounds.height/1.5))
        //bowl
        let center = CGPoint(x:bounds.width/2, y: (bounds.height/1.5))
        let radius: CGFloat = bounds.width - (bounds.width/2 - 100) - (bounds.width/2 - 100) + 2
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 3.14
        let path2 = UIBezierPath(arcCenter: center,
            radius: radius/2 - 2.0/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        path2.lineWidth = 2
        path.appendPath(path2)
        path.stroke()
        
        //water
        UIColor.blueColor().setFill()
        
        let waterRadius: CGFloat = bounds.width - (bounds.width/2 - 100) - (bounds.width/2 - 100) - 5
        let path3 = UIBezierPath(arcCenter: center,
            radius: waterRadius/2 - 2.0/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        path3.lineWidth = 2
        path3.fill()
        
        let path4 = UIBezierPath()
        path4.lineWidth = 2
        path4.moveToPoint(CGPoint(
            x:bounds.width/2 - 96.5,
            y:bounds.height/6))
        path4.addLineToPoint(CGPoint(
            x:bounds.width/2 - 96.5,
            y:bounds.height/1.5 + 2))
        path4.addLineToPoint(CGPoint(
            x:bounds.width/2 + 96.5,
            y:bounds.height/1.5 + 2))
        path4.addLineToPoint(CGPoint(
            x:bounds.width/2 + 96.5,
            y:bounds.height/6))
        path4.closePath()
        path4.fill()
    }
}
