//
//  WishStoringView.swift
//  tmibragimovPW3
//
//  Created by тимур on 05.12.2024.
//

import Foundation
import UIKit

final class WishStoringView: UIView {
    private enum Constants {
        static let backgroundColor: UIColor = UIColor(white: 0.95, alpha: 1)
    }
    let tableView: UITableView = UITableView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = Constants.backgroundColor
        configureTable()
    }
    
    private func configureTable() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 15
        
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        tableView.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1 * 10)
        ])
    }
}
