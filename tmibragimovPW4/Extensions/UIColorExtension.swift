//
//  UIColor+blend.swift
//  tmibragimovPW2
//
//  Created by тимур on 30.10.2024.
//

import Foundation
import UIKit


extension UIColor {
    func blendWithWhite(fraction: CGFloat) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let blendedRed = red * (1 - fraction) + 1 * fraction
        let blendedGreen = green * (1 - fraction) + 1 * fraction
        let blendedBlue = blue * (1 - fraction) + 1 * fraction
        
        return UIColor(red: blendedRed, green: blendedGreen, blue: blendedBlue, alpha: 1)
    }
    
    func luminance() -> CGFloat {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        red = red * 255
        green = green * 255
        blue = blue * 255
        let luminance = (0.2126 * red + 0.7152 * green + 0.0722 * blue) / 255.0
        return luminance
    }
}
