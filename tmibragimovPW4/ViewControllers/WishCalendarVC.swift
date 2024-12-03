//
//  ScheduleWishesVC.swift
//  tmibragimovPW4
//
//  Created by тимур on 07.12.2024.
//

import UIKit
import Foundation

class WishCalendarVC: UIViewController {
    private let wishCalendarView = WishCalendarView()
    private let defaults = UserDefaults.standard
    private var events: [WishEventModel] = []

    override func loadView() {
        view = wishCalendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            if let data = defaults.data(forKey: "events") {
                let decoder = JSONDecoder()
                events = try decoder.decode([WishEventModel].self, from: data)
            }
        } catch {}
        wishCalendarView.collectionView.delegate = self
        wishCalendarView.collectionView.dataSource = self
        navigationItem.rightBarButtonItem = wishCalendarView.addEventButton
        wishCalendarView.addEvent = addEvent
    }
    
    private func addEvent() {
        let vc = WishEventCreationVC()
        vc.close = { [weak self] in self?.dismiss(animated: true) }
        vc.addEvent = { [weak self] event in
            self?.events.append(event)
            self?.wishCalendarView.collectionView.reloadData()
            do {
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(self?.events)
                self?.defaults.set(encoded, forKey: "events")
            } catch {}
        }
        present(vc, animated: true)
    }
}

extension WishCalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 130)
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        print("Cell tapped at index \(indexPath.item)")
    }
}

extension WishCalendarVC: UICollectionViewDataSource {
    func collectionView(
        _
        collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return events.count
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseId, for: indexPath)
        guard let wishEventCell = cell as? WishEventCell else { return cell }
        
        wishEventCell.configure(with: events[indexPath.row])
        return wishEventCell
    }
}
