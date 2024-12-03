//
//  ScheduleWishesView.swift
//  tmibragimovPW4
//
//  Created by тимур on 07.12.2024.
//

import UIKit

final class WishCalendarView: UIView {
    let addEventButton: UIBarButtonItem = UIBarButtonItem()
    let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var addEvent: (() -> Void)?
    
    private enum Constants {
        static let backgroundColor: UIColor = UIColor(white: 0.95, alpha: 1)
    }
    
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
        configureCollection()
        configureAddButton()
    }
    
    private func configureCollection() {
        collectionView.alwaysBounceVertical = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        if let layout = collectionView.collectionViewLayout as?
            UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
            layout.invalidateLayout()
        }
        /* Temporary line */
        collectionView.register(
            WishEventCell.self,
            forCellWithReuseIdentifier: WishEventCell.reuseId
        )
        
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            collectionView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: 0)
        ])
    }
    
    private func configureAddButton() {
        addEventButton.title = "Add Event"
        addEventButton.target = self
        addEventButton.action = #selector(addEventButtonTapped)
    }
    
    @objc
    private func addEventButtonTapped() {
        addEvent?()
    }
}
