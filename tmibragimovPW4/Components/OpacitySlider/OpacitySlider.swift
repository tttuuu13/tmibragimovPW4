//
//  OpacitySlider.swift
//  tmibragimovPW2
//
//  Created by тимур on 27.10.2024.
//

import Foundation
import UIKit


final class OpacitySlider: GradientSlider {
    init(color: UIColor) {
        super.init(minColor: .white, maxColor: color, maxValue: 100)
    }
    
    override func draw(_ rect: CGRect) {
        UIImage.drawOpacityGradient(on: rect, color: maxColor)
    }
}
