//
//  FavoritesListViewCell.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class FavoritesListViewCell: UICollectionViewCell {

    // MARK: - IBOutlets.
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet var mainProducts: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    fileprivate func setupMainProducts(images: [UIImage?]) {
        for (index, image) in images.enumerated() {
            mainProducts[index].image = image
        }
    }
}

// MARK: - FavoritesCellProtocol implementation.
extension FavoritesListViewCell: FavoritesCellProtocol {
    func setup(model: FavoritesCellViewModelProtocol) {
        if let cellModel = model as? FavoritesListCellViewModel {
            self.titleLabel.text = cellModel.favoriteListModel.description
            self.valueLabel.text = "\(cellModel.favoriteListModel.products.count)"
            setupMainProducts(images: cellModel.firtsProducts)
        }
    }
}
