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

    private var viewModel: FavoritesListCellProtocol? { didSet { unbind(from: oldValue) } }
    private var firstProducts = [FavoritesProductCellViewModel]()
    private var firstImages = [UIImage]()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    fileprivate func setupMainProducts(images: [UIImage]) {
        for (index, image) in images.enumerated() {
            mainProducts[index].image = image
        }
    }

    // MARK: - Bind and unbind functions.
    fileprivate func bind(to viewModel: FavoritesListCellProtocol) {
        viewModel.imageWithPath.observe(on: self) { [weak self] (imageWithPath) in
            guard let object = imageWithPath else { return }
            self?.mainProducts[object.index].image = object.image
        }
    }

    fileprivate func unbind(from item: FavoritesListCellProtocol?) {
        item?.imageWithPath.remove(observer: self)
    }
}

// MARK: - FavoritesCellProtocol implementation.
extension FavoritesListViewCell: FavoritesCellProtocol {
    func setup(model: FavoritesCellViewModelProtocol) {
        if let viewModel = model as? FavoritesListCellProtocol {
            self.titleLabel.text = viewModel.favoriteListModel.name
            self.valueLabel.text = "\(viewModel.favoriteListModel.products.count)"
            self.viewModel = viewModel
            self.viewModel?.downloadImages()
            bind(to: viewModel)
        }
    }
}
