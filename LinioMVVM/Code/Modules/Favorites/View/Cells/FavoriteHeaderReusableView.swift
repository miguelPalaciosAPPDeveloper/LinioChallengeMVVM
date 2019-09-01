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
    func setup(model: FavoritesSectionModel) {
        self.titleLabel.text = model.title
    }
}
