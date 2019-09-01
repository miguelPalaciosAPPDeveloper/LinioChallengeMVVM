//
//  FavoriteHeaderReusableView.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class FavoriteHeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

// MARK: - FavoritesCellProtocol implementation.
extension FavoriteHeaderReusableView: FavoritesCellProtocol {
    func setup(model: FavoritesCellModelProtocol) {
        if let cellModel = model as? FavoritesSectionModel {
            self.titleLabel.text = cellModel.title
        }
    }
}
