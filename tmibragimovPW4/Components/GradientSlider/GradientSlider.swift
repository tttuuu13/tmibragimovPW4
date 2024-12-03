//
//  GradientSlider.swift
//  tmibragimovPW2
//
//  Created by тимур on 27.10.2024.
//

import Foundation
import UIKit


class GradientSlider: UISlider {
    var minColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    var maxColor: UIColor {
        didSet {
            setNeedsDisplay()
        }
    }
    
    init(minColor: UIColor, maxColor: UIColor, maxValue: Float) {
        self.minColor = minColor
        self.maxColor = maxColor
        super.init(frame: .zero)
        maximumValue = maxValue
        configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        UIImage.drawColorGradient(on: rect, colors: [minColor, maxColor])
    }
    
    override func setValue(_ value: Float, animated: Bool) {
        super.setValue(value, animated: animated)
    }
    
    private func configure() {
        minimumValue = 0
        value = maximumValue
        layer.cornerRadius = 18
        clipsToBounds = true
        tintColor = .clear
        maximumTrackTintColor = .clear
        minimumTrackTintColor = .clear
    }
    
    func setThumbColor(to color: UIColor) {
        let circleImage = UIImage.thumbCircle(color: color)
        setThumbImage(circleImage, for: .normal)
    }
}
