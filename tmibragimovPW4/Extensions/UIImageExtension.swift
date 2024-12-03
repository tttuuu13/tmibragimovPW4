//
//  UIImage+gradientImage.swift
//  tmibragimovPW2
//
//  Created by тимур on 26.10.2024.
//

import Foundation
import UIKit


extension UIImage {
    static func drawColorGradient(on rect: CGRect, colors: [UIColor]) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = colors.map { $0.cgColor }
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: nil) else { return }
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
    }
    
    static func drawOpacityGradient(on rect: CGRect, color: UIColor) {
        let opacityBg = UIImage(named: "opacitySliderBg")
        opacityBg?.draw(in: rect)
        drawColorGradient(on: rect, colors: [.clear, color])
    }
    
    static func thumbCircle(color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 36, height: 36))
        return renderer.image { context in
            let rect = CGRect(x: 3, y: 3, width: 29, height: 29)
            context.cgContext.setFillColor(color.cgColor)
            context.cgContext.setStrokeColor(UIColor.white.cgColor)
            context.cgContext.setLineWidth(3)
            context.cgContext.addEllipse(in: rect)
            context.cgContext.drawPath(using: .fillStroke)
        }
    }
}
