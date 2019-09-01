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
    func setup(model: FavoritesCellViewModelProtocol)
}

protocol FavoritesCellViewModelProtocol {
    var cellType: FavoriteCellType { get }
}

// MARK: - Models.
struct FavoritesSectionModel {
    let title: String?
    let headerSize: CGSize
    let cells: [FavoritesCellViewModelProtocol]
}

struct FavoritesListCellViewModel: FavoritesCellViewModelProtocol {
    let firtsProducts: [UIImage?]
    let favoriteListModel: LinioFavoritesList
    let cellType: FavoriteCellType
}

struct FavoritesProductCellViewModel: FavoritesCellViewModelProtocol {
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


