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
}
