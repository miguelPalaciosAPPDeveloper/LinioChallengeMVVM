//
//  FavoritesProtocols.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols.
protocol FavoritesViewModelProtocol: class {
    var items: Observable<[FavoritesSectionModel]> { get }
    var route: Observable<FavoritesViewModelRoute> { get }

    func fetchFavorites()
    func didTapAddProduct()
    func didSelect(item: FavoritesCellViewModelProtocol)
}

// MARK: - Enums.
enum FavoritesViewModelRoute {
    case addProduct
    case closeLoader
    case fetchFavorites
    case showFavoritesList(list: LinioFavoritesList)
    case showProductDetail(product: LinioProduct, productImage: UIImage?)
}
