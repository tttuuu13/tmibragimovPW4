//
//  WishEventCreationView.swift
//  tmibragimovPW4
//
//  Created by тимур on 08.12.2024.
//

import UIKit

class WishEventCreationView: UIView {
    private let title: UILabel = UILabel()
    private let titleDescriptionSection: UIStackView = UIStackView()
    private let eventTimeSection: UIStackView = UIStackView()
    private enum Constants {
        static let backgroundColor: UIColor = UIColor(white: 0.95, alpha: 1)
        static let insetH: CGFloat = 15
        static let insetV: CGFloat = 25
        static let sectionsSpacing: CGFloat = 30
        static let sectionCornerRadius: CGFloat = 10
        static let cellHeight: CGFloat = 50
        static let sectionLayoutMargins = UIEdgeInsets(top: 0, left: Constants.insetH, bottom: 0, right: Constants.insetH)
    }
    let cancelButton: UIButton = UIButton(type: .system)
    let addButton: UIButton = UIButton(type: .system)
    let eventTitleField: UITextField = UITextField()
    let eventDescriptionField: UITextField = UITextField()
    let eventStartDateTime: UIDatePicker = UIDatePicker()
    let eventEndDateTime: UIDatePicker = UIDatePicker()
    let saveToCalendarSwitch: UISwitch = UISwitch()
    var dataChanged: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = Constants.backgroundColor
        configureTitle()
        configureAddButton()
        configureCancelButton()
        configureTitleDescriptionSection()
        configureEventTimeSection()
    }
    
    private func configureTitle() {
        addSubview(title)
        title.text = "New Event"
        title.font = .systemFont(ofSize: 18, weight: .semibold)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: Constants.insetV),
            title.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func configureAddButton() {
        addSubview(addButton)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(.red, for: .normal)
        addButton.setTitle("Add", for: .disabled)
        addButton.setTitleColor(.lightGray, for: .disabled)
        addButton.isEnabled = false
        addButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * Constants.insetH)
        ])
    }
    
    private func configureCancelButton() {
        addSubview(cancelButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.red, for: .normal)
        cancelButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.insetH)
        ])
    }
    
    private func configureTitleDescriptionSection() {
        configureEventTitleField()
        configureEventDescriptionField()
        addSubview(titleDescriptionSection)
        titleDescriptionSection.addArrangedSubview(eventTitleField)
        titleDescriptionSection.addArrangedSubview(createSeparator())
        titleDescriptionSection.addArrangedSubview(eventDescriptionField)
        titleDescriptionSection.backgroundColor = .white
        titleDescriptionSection.axis = .vertical
        titleDescriptionSection.layer.cornerRadius = Constants.sectionCornerRadius
        titleDescriptionSection.layoutMargins = Constants.sectionLayoutMargins
        titleDescriptionSection.isLayoutMarginsRelativeArrangement = true
        
        titleDescriptionSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleDescriptionSection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Constants.sectionsSpacing),
            titleDescriptionSection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.insetH),
            titleDescriptionSection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * Constants.insetH),
        ])
    }
    
    private func configureEventTitleField() {
        eventTitleField.placeholder = "Title"
        eventTitleField.addTarget(self, action: #selector(textFieldChanged), for: .allEditingEvents)
        eventTitleField.heightAnchor.constraint(equalToConstant: Constants.cellHeight).isActive = true
    }
    
    private func configureEventDescriptionField() {
        eventDescriptionField.placeholder = "Description"
        eventDescriptionField.addTarget(self, action: #selector(textFieldChanged), for: .allEditingEvents)
        eventDescriptionField.heightAnchor.constraint(equalToConstant: Constants.cellHeight).isActive = true
    }
    
    private func configureEventTimeSection() {
        let startCell = createStartCell()
        let endCell = createEndCell()
        let saveToCalendarCell = createSaveToCalendarCell()
        
        addSubview(eventTimeSection)
        eventTimeSection.addArrangedSubview(startCell)
        eventTimeSection.addArrangedSubview(createSeparator())
        eventTimeSection.addArrangedSubview(endCell)
        eventTimeSection.addArrangedSubview(createSeparator())
        eventTimeSection.addArrangedSubview(saveToCalendarCell)
        eventTimeSection.axis = .vertical
        eventTimeSection.backgroundColor = .white
        eventTimeSection.layer.cornerRadius = Constants.sectionCornerRadius
        eventTimeSection.layoutMargins = Constants.sectionLayoutMargins
        eventTimeSection.isLayoutMarginsRelativeArrangement = true

        eventTimeSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventTimeSection.topAnchor.constraint(equalTo: titleDescriptionSection.bottomAnchor, constant: Constants.sectionsSpacing),
            eventTimeSection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.insetH),
            eventTimeSection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * Constants.insetH)
        ])
    }
    
    private func createStartCell() -> UIStackView {
        let startCell = UIStackView()
        let startText = UILabel()
        startText.text = "Starts"
        startCell.axis = .horizontal
        startCell.addArrangedSubview(startText)
        startCell.addArrangedSubview(eventStartDateTime)
        startCell.heightAnchor.constraint(equalToConstant: Constants.cellHeight).isActive = true
        return startCell
    }
    
    private func createEndCell() -> UIStackView {
        let endCell = UIStackView()
        let endText = UILabel()
        eventEndDateTime.setDate(Date(timeIntervalSinceNow: 3600), animated: false)
        endText.text = "Ends"
        endCell.axis = .horizontal
        endCell.addArrangedSubview(endText)
        endCell.addArrangedSubview(eventEndDateTime)
        endCell.heightAnchor.constraint(equalToConstant: Constants.cellHeight).isActive = true
        return endCell
    }
    
    private func createSaveToCalendarCell() -> UIStackView {
        let cell = UIStackView()
        let text = UILabel()
        saveToCalendarSwitch.isOn = true
        text.text = "Save to Calendar"
        cell.axis = .horizontal
        cell.alignment = .center
        cell.addArrangedSubview(text)
        cell.addArrangedSubview(saveToCalendarSwitch)
        cell.heightAnchor.constraint(equalToConstant: Constants.cellHeight).isActive = true
        return cell
    }
    
    private func createSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .separator
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return separator
    }
    
    @objc
    private func textFieldChanged() {
        dataChanged?()
    }
}
