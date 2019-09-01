//
//  FavoriteModels.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

// MARK: - Protocols
protocol FavoritesCellProtocol {
    func setup(model: FavoritesCellModelProtocol)
}

protocol FavoritesCellModelProtocol {}

// MARK: - Models.
struct FavoritesSectionModel: FavoritesCellModelProtocol {
    let title: String?
    let headerSize: CGSize
}

struct FavoritesListCellModel: FavoritesCellModelProtocol {
    let firtsProducts: [UIImage?]
    let favoriteListModel: LinioFavoritesList
    let cellType: FavoriteCellType
}

struct FavoritesProductCellModel: FavoritesCellModelProtocol {
    let productImage: UIImage?
    let productModel: LinioProduct
    let cellType: FavoriteCellType
}

// MARK: - Enums.
enum FavoriteCellType {
    case favoriteList, favoriteProducts

    var identifer: String {
        switch self {
        case .favoriteList:
            return FavoritesListViewCell.identifier
        case .favoriteProducts:
            return ProductViewCell.identifier
        }
    }
}

enum ProductStateType: String, RawRepresentable {
    case new = "new"
    case refurbished = "refurbished"
}


