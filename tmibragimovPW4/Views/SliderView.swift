//
//  SliderView.swift
//  tmibragimovPW2
//
//  Created by тимур on 29.10.2024.
//

import Foundation
import UIKit


final class SliderView: UIStackView {
    let name: String
    let slider: GradientSlider
    let valueField: ValueField
    var value: Float {
        didSet {
            valueField.text = String(Int(value))
            slider.value = min(value, slider.maximumValue)
        }
    }
    
    
    init(name:String, slider: GradientSlider, valueField: ValueField) {
        self.name = name
        self.slider = slider
        self.valueField = valueField
        value = slider.maximumValue
        super.init(frame: .zero)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        axis = .vertical
        spacing = 7
        translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = name
        nameLabel.font = Constants.labelFont
        nameLabel.textColor = .secondaryLabel
        addArrangedSubview(nameLabel)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        valueField.translatesAutoresizingMaskIntoConstraints = false
        valueField.addTarget(self, action: #selector(valueFieldValueChanged), for: .editingChanged)
        
        let sliderValueStack = UIStackView(arrangedSubviews: [slider, valueField])
        sliderValueStack.translatesAutoresizingMaskIntoConstraints = false
        sliderValueStack.spacing = 11
        
        addArrangedSubview(sliderValueStack)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 330),
        ])
    }
    
    @objc func sliderValueChanged() {
        value = slider.value
    }
    
    @objc func valueFieldValueChanged() {
        value = min(Float(valueField.text!) ?? 0, slider.maximumValue)
    }
    
    enum Constants {
        static let labelFont: UIFont = .systemFont(ofSize: 13, weight: .semibold)
    }
}
