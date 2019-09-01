//
//  ProductViewCell.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class ProductViewCell: UICollectionViewCell {

    // MARK: - IBOutlets.
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var plus48ImageView: UIImageView!
    @IBOutlet weak var refurbishedImageView: UIImageView!
    @IBOutlet weak var newProductImageView: UIImageView!
    @IBOutlet weak var airplaneImageView: UIImageView!
    @IBOutlet weak var freeShippingImageView: UIImageView!
    @IBOutlet weak var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    fileprivate func setupBadges(product: LinioProduct) {
        let isPlus48 = product.linioPlusLevel > 1
        let productState = ProductStateType(rawValue: product.conditionType) ?? .new
        
        self.plusImageView.isHidden = isPlus48
        self.plus48ImageView.isHidden = !isPlus48
        self.refurbishedImageView.isHidden = productState == .new
        self.newProductImageView.isHidden = productState == .refurbished
        self.airplaneImageView.isHidden = !product.imported
        self.freeShippingImageView.isHidden = !product.freeShipping
    }
}

// MARK: - FavoritesCellProtocol implementation.
extension ProductViewCell: FavoritesCellProtocol {
    func setup(model: FavoritesCellViewModelProtocol) {
        if let cellModel = model as? FavoritesProductCellViewModel {
            self.productImageView.image = cellModel.productImage
            self.setupBadges(product: cellModel.productModel)
        }
    }
}
