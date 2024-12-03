//
//  AddWishCell.swift
//  tmibragimovPW2
//
//  Created by тимур on 06.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    static let reuseId: String = "AddWishCell"
    private enum Constants {
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 5
        static let wrapOffsetH: CGFloat = 10
        
        static let addButtonColor: UIColor = .black.withAlphaComponent(0.2)
        static let addButtonSize: CGFloat = 30
        static let addButtonOffsetH: CGFloat = 2
        
        static let textFieldOffsetH: CGFloat = 5
    }
    private let textField: UITextField = UITextField()
    private let addButton: UIButton = UIButton(type: .system)
    var addWish: ((String) -> Void)?
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        let wrap: UIView = UIView()
        wrap.backgroundColor = Constants.wrapColor
        wrap.layer.cornerRadius = Constants.wrapRadius
        configureTextField()
        configureAddButton()
        wrap.addSubview(textField)
        wrap.addSubview(addButton)
        contentView.addSubview(wrap)
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrap.topAnchor.constraint(equalTo: topAnchor, constant: Constants.wrapOffsetV),
            wrap.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1 * Constants.wrapOffsetV),
            wrap.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.wrapOffsetH),
            wrap.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * Constants.wrapOffsetH),
            addButton.widthAnchor.constraint(equalToConstant: Constants.addButtonSize),
            addButton.heightAnchor.constraint(equalToConstant: Constants.addButtonSize),
            addButton.trailingAnchor.constraint(equalTo: wrap.trailingAnchor, constant: -1 * Constants.addButtonOffsetH),
            addButton.centerYAnchor.constraint(equalTo: wrap.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.addButtonSize),
            textField.centerYAnchor.constraint(equalTo: wrap.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: wrap.leadingAnchor, constant: Constants.textFieldOffsetH),
            textField.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: Constants.textFieldOffsetH)
        ])
        
    }
    
    private func configureTextField() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Write your wish here"
    }
    
    private func configureAddButton() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = Constants.addButtonColor
        addButton.layer.cornerRadius = Constants.wrapRadius
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func addButtonTapped() {
        if textField.hasText {
            addWish?(textField.text ?? "")
            textField.text = ""
        }
    }
}
