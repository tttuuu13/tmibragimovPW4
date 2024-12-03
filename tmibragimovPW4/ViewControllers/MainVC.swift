//
//  ViewController.swift
//  tmibragimovPW2
//
//  Created by тимур on 23.10.2024.
//

import UIKit

class MainVC: UIViewController {
    var color: UIColor = Constants.defaultBackgroundColor {
        didSet {
            view.backgroundColor = color
            addWishButton.titleLabel?.textColor = color
            scheduleWishesButton.titleLabel?.textColor = color
            UIView.animate(withDuration: 0.3, animations: {
                if self.color.luminance() < 0.5 {
                    self.descriptionLabel.textColor = .white
                    self.titleLabel.textColor = .white
                    self.addWishButton.backgroundColor = Constants.elementsBackgroundColorWhite
                    self.scheduleWishesButton.backgroundColor = Constants.elementsBackgroundColorWhite
                    self.slidersVC.view.backgroundColor = Constants.elementsBackgroundColorWhite
                } else {
                    self.descriptionLabel.textColor = .black
                    self.titleLabel.textColor = .black
                    self.addWishButton.backgroundColor = Constants.elementsBackgroundColorBlack
                    self.scheduleWishesButton.backgroundColor = Constants.elementsBackgroundColorBlack
                    self.slidersVC.view.backgroundColor = Constants.elementsBackgroundColorBlack
                }
            })
        }
    }
    private let addWishButton: UIButton = UIButton()
    private let scheduleWishesButton: UIButton = UIButton()
    private let descriptionLabel: UILabel = UILabel()
    private let titleLabel: UILabel = UILabel()
    private var buttonStack: UIStackView = UIStackView()
    private let slidersVC: SlidersVC = SlidersVC(color: Constants.defaultBackgroundColor, colorChanged: nil)
    
    enum Constants {
        static let defaultBackgroundColor: UIColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.8)
        static let elementsBackgroundColorWhite: UIColor = .white.withAlphaComponent(0.8)
        static let elementsBackgroundColorBlack: UIColor = .black.withAlphaComponent(0.2)
        static let titleFont: UIFont = .systemFont(ofSize: 30, weight: .semibold)
        static let descriptionFont: UIFont = .systemFont(ofSize: 16, weight: .regular)
        static let addButtonTitle: String = "My wishes"
        static let scheduleWishesButtonTitle: String = "Schedule wishes"
        static let buttonHeight: CGFloat = 50
        static let componentsOffsetH: CGFloat = 10
        static let componentsOffsetV: CGFloat = 20
        static let stackSpacing: CGFloat = 20
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        color = Constants.defaultBackgroundColor
        configureAddWishButton()
        configureScheduleWishesButton()
        configureButtonStack()
        configureSliders()
        configureTitle()
        configureDescription()
    }
    
    private func configureTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Wish Maker"
        titleLabel.font = Constants.titleFont
        titleLabel.textColor = .black
        
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func configureDescription() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = .max
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = "This is my implementation of the Wish Maker app, feel free to use sliders to change background color to your liking"
        descriptionLabel.font = Constants.descriptionFont
        descriptionLabel.textColor = .black
        
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    private func configureButtonStack() {
        buttonStack = UIStackView(arrangedSubviews: [addWishButton, scheduleWishesButton])
        view.addSubview(buttonStack)
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .vertical
        buttonStack.spacing = Constants.stackSpacing
        
        NSLayoutConstraint.activate([
            buttonStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1 * Constants.componentsOffsetV),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.componentsOffsetH),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * Constants.componentsOffsetH),
            addWishButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            scheduleWishesButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }
    
    private func configureAddWishButton() {
        addWishButton.addTarget(self, action: #selector(addWishButtonTapped), for: .touchUpInside)
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle(Constants.addButtonTitle, for: .normal)
        addWishButton.layer.cornerRadius = 20
    }
    
    private func configureScheduleWishesButton() {
        scheduleWishesButton.addTarget(self, action: #selector(scheduleWishesButtonTapped), for: .touchUpInside)
        scheduleWishesButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleWishesButton.setTitle(Constants.scheduleWishesButtonTitle, for: .normal)
        scheduleWishesButton.layer.cornerRadius = 20
    }
    
    private func configureSliders() {
        slidersVC.colorChanged = updateColor
        view.addSubview(slidersVC.view)
        addChild(slidersVC)
        
        NSLayoutConstraint.activate([
            slidersVC.view.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -20),
            slidersVC.view.heightAnchor.constraint(equalToConstant: 400),
            slidersVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            slidersVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * 10)
        ])
    }
    
    private func updateColor(color: UIColor) {
        self.color = color
    }
    
    @objc
    private func addWishButtonTapped() {
        present(WishStoringVC(), animated: true);
    }
    
    @objc
    private func scheduleWishesButtonTapped() {
        let vc = WishCalendarVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}
