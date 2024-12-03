//
//  SlidersView.swift
//  tmibragimovPW2
//
//  Created by тимур on 29.10.2024.
//

import Foundation
import UIKit


final class SlidersVC: UIViewController {
    private enum Constants {
        static let backgroundColor: UIColor = .white.withAlphaComponent(0.8)
    }
    var colorChanged: ((UIColor) -> Void)?
    var color: UIColor
    var sliderViews = [
        SliderView(name: "RED", slider: GradientSlider(minColor: .black, maxColor: .red, maxValue: 255), valueField: ValueField(maxValue: 255)),
        SliderView(name: "GREEN", slider: GradientSlider(minColor: .black, maxColor: .green, maxValue: 255), valueField: ValueField(maxValue: 255)),
        SliderView(name: "BLUE", slider: GradientSlider(minColor: .black, maxColor: .blue, maxValue: 255), valueField: ValueField(maxValue: 255)),
        SliderView(name: "OPACITY", slider: OpacitySlider(color: .white), valueField: ValueField(maxValue: 100))
    ]
    
    init(color: UIColor, colorChanged: ((UIColor) -> Void)?) {
        self.color = color
        self.colorChanged = colorChanged
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func configure() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Constants.backgroundColor
        view.layer.cornerRadius = 20
        setColor(color: color)
        updateSliders()
        let slidersStack = UIStackView(arrangedSubviews: sliderViews)
        slidersStack.translatesAutoresizingMaskIntoConstraints = false
        slidersStack.axis = .vertical
        slidersStack.spacing = 40
        view.addSubview(slidersStack)
        
        sliderViews.forEach { sliderView in
            sliderView.slider.addTarget(self, action: #selector(updateSliders), for: .valueChanged)
            sliderView.valueField.addTarget(self, action: #selector(updateSliders), for: .editingChanged)
        }
        
        NSLayoutConstraint.activate([
            slidersStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            slidersStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    
    @objc func updateSliders() {
        color = getColor()
        colorChanged?(color)
        let red = CGFloat(sliderViews[0].value / 255)
        let green = CGFloat(sliderViews[1].value / 255)
        let blue = CGFloat(sliderViews[2].value / 255)
        let alpha = CGFloat(sliderViews[3].value / 100)
        
        sliderViews[0].slider.minColor = UIColor(red: 0, green: green, blue: blue, alpha: 1)
        sliderViews[0].slider.maxColor = UIColor(red: 255, green: green, blue: blue, alpha: 1)
        sliderViews[1].slider.minColor = UIColor(red: red, green: 0, blue: blue, alpha: 1)
        sliderViews[1].slider.maxColor = UIColor(red: red, green: 255, blue: blue, alpha: 1)
        sliderViews[2].slider.minColor = UIColor(red: red, green: green, blue: 0, alpha: 1)
        sliderViews[2].slider.maxColor = UIColor(red: red, green: green, blue: 255, alpha: 1)
        sliderViews[3].slider.maxColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        sliderViews.forEach { sliderView in
            sliderView.slider.setThumbColor(to: color.blendWithWhite(fraction: 1 - alpha))
        }
    }
    
    func setColor(color: UIColor) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        sliderViews[0].value = Float(red * 255)
        sliderViews[1].value = Float(green * 255)
        sliderViews[2].value = Float(blue * 255)
        sliderViews[3].slider.maxColor = color
        sliderViews[3].value = Float(alpha * 100)
    }
    
    func getColor() -> UIColor {
        let color = UIColor(red: CGFloat(sliderViews[0].slider.value) / 255, green: CGFloat(sliderViews[1].slider.value) / 255, blue: CGFloat(sliderViews[2].slider.value) / 255, alpha: CGFloat(sliderViews[3].slider.value) / 100)
        return color
    }
}
