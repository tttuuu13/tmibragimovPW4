//
//  WishEventCell.swift
//  tmibragimovPW4
//
//  Created by тимур on 08.12.2024.
//

import UIKit
import Foundation

final class WishEventCell: UICollectionViewCell {
    static let reuseId: String = "WishEventCell"
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    private enum Constants {
        static let wrapBackgroundColor: UIColor = .white
        static let wrapCornerRadius: CGFloat = 16
        static let wrapOffset: CGFloat = 5
        static let cellInnerOffset: CGFloat = 10
        static let spaceBetweenCellElems: CGFloat = 3
        static let titleFont: UIFont = .systemFont(ofSize: 24, weight: .semibold)
        static let descriptionFontColor: UIColor = .black.withAlphaComponent(0.8)
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy HH:mm"
        startDateLabel.text = "From \(dateFormatter.string(from: event.startDate))"
        endDateLabel.text = "To \(dateFormatter.string(from: event.endDate))"
    }
    
    func configureWrap() {
        contentView.addSubview(wrapView)
        wrapView.backgroundColor = Constants.wrapBackgroundColor
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wrapView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.wrapOffset),
            wrapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1 * Constants.wrapOffset),
            wrapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.wrapOffset),
            wrapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1 * Constants.wrapOffset)
        ])
    }
    
    func configureTitleLabel() {
        wrapView.addSubview(titleLabel)
        titleLabel.font = Constants.titleFont
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: Constants.cellInnerOffset),
            titleLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellInnerOffset)
        ])
    }
    
    func configureDescriptionLabel() {
        wrapView.addSubview(descriptionLabel)
        descriptionLabel.textColor = Constants.descriptionFontColor
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.spaceBetweenCellElems),
            descriptionLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellInnerOffset)
        ])
    }
    
    func configureStartDateLabel() {
        wrapView.addSubview(startDateLabel)
        startDateLabel.textColor = Constants.descriptionFontColor
        
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.spaceBetweenCellElems),
            startDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellInnerOffset)
        ])
    }
    
    func configureEndDateLabel() {
        wrapView.addSubview(endDateLabel)
        endDateLabel.textColor = Constants.descriptionFontColor
        
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            endDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: Constants.spaceBetweenCellElems),
            endDateLabel.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: Constants.cellInnerOffset)
        ])
    }
}
