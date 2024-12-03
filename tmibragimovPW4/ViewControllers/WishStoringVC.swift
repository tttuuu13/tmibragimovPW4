//
//  WishStoringVC.swift
//  tmibragimovPW3
//
//  Created by тимур on 05.12.2024.
//

import Foundation
import UIKit

final class WishStoringVC: UIViewController {
    private let defaults = UserDefaults.standard
    let wishStoringView = WishStoringView()
    private var wishArray: [String] = []
    private enum Constants {
        static let wishesKey: String = "wishesArray"
        static let numberOfSections: Int = 2
    }

    override func loadView() {
        wishArray = defaults.array(forKey: Constants.wishesKey) as? [String] ?? []
        view = wishStoringView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishStoringView.tableView.dataSource = self
    }
}

extension WishStoringVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return wishArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            return wishCell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath)
            guard let addWishCell = cell as? AddWishCell else { return cell }
            addWishCell.addWish = { [weak self] wishText in
                self?.wishArray.append(wishText)
                self?.defaults.set(self?.wishArray, forKey: Constants.wishesKey)
                tableView.reloadData()
            }
            return addWishCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.numberOfSections
    }
}
