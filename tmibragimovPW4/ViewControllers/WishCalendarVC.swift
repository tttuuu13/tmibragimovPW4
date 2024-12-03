//
//  ScheduleWishesVC.swift
//  tmibragimovPW4
//
//  Created by тимур on 07.12.2024.
//

import UIKit

class WishCalendarVC: UIViewController {
    private let wishCalendarView = WishCalendarView()

    override func loadView() {
        view = wishCalendarView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishCalendarView.collectionView.delegate = self
        wishCalendarView.collectionView.dataSource = self
    }
}

extension WishCalendarVC: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _
        collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 10, height: 100)
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
        return 10
    }
    func collectionView(
        _
        collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
