//
//  View.swift
//  tmibragimovPW2
//
//  Created by тимур on 27.10.2024.
//

import Foundation
import UIKit


final class ValueField: UITextField {
    let maxValue: Int
    
    init(maxValue: Int) {
        self.maxValue = maxValue
        super.init(frame: .zero)
        configure()
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        backgroundColor = .white
        layer.cornerRadius = 8
        textAlignment = .center
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 67).isActive = true
        heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
        font = .systemFont(ofSize: 17, weight: .semibold)
        keyboardType = .numberPad
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        guard let value = Int(text ?? "0") else { return }
        text = String(min(maxValue, value))
    }
}
