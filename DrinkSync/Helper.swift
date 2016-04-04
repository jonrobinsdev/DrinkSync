//
//  Helper.swift
//  DrinkSync
//
//  Created by Jonathan Robins on 3/21/16.
//  Copyright © 2016 robins. All rights reserved.
//

import Foundation
import UIKit

class Helper{
     static func roundFloatToOneDecimal(var value:Float) -> Float{
        value *= 10
        value = round(value)
        value /= 10
        return value
     }
    
    static func roundCGFloatToOneDecimal(var value:CGFloat) -> CGFloat{
        value *= 10
        value = round(value)
        value /= 10
        return value
    }
    
    static func indexOfCharacter(char: Character, string: String) -> Int? {
        if let idx = string.characters.indexOf(char) {
            return string.startIndex.distanceTo(idx)
        }
        return nil
    }
}
