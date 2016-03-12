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
        let ctx: CGContextRef = UIGraphicsGetCurrentContext()!
        let roundRect:CGPathRef = UIBezierPath(roundedRect: CGRectMake(rect.size.width/2, rect.size.height/2, 100, 250), byRoundingCorners:.AllCorners, cornerRadii: CGSizeMake(16, 16)).CGPath
        
        CGContextAddPath(ctx, roundRect)
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        
        CGContextClosePath(ctx)
        CGContextFillPath(ctx)

    }
}
