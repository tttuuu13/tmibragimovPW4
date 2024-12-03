//
//  WishEventCreationVC.swift
//  tmibragimovPW4
//
//  Created by тимур on 08.12.2024.
//

import UIKit
import Foundation

class WishEventCreationVC: UIViewController {
    private let wishEventCreationView = WishEventCreationView()
    private let calendarManager = CalendarManager()
    var close: (() -> Void)?
    var addEvent: ((WishEventModel) -> Void)?

    override func loadView() {
        view = wishEventCreationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishEventCreationView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        wishEventCreationView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        wishEventCreationView.dataChanged = { [weak self] in
            if self?.wishEventCreationView.eventTitleField.hasText ?? false && self?.wishEventCreationView.eventDescriptionField.hasText ?? false {
                self?.wishEventCreationView.addButton.isEnabled = true
            } else {
                self?.wishEventCreationView.addButton.isEnabled = false
            }
        }
    }
    
    @objc
    private func addButtonTapped() {
        let event = WishEventModel(
            title: wishEventCreationView.eventTitleField.text ?? "",
            description: wishEventCreationView.eventDescriptionField.text ?? "",
            startDate: wishEventCreationView.eventStartDateTime.date,
            endDate: wishEventCreationView.eventEndDateTime.date
        )
        addEvent?(event)
        if wishEventCreationView.saveToCalendarSwitch.isOn {
            let isCreated = calendarManager.create(eventModel:  CalendarEventModel(title: event.title, startDate: event.startDate, endDate: event.endDate, note: event.description))
        }
        close?()
    }
    
    @objc
    private func cancelButtonTapped() {
        close?()
    }
}
