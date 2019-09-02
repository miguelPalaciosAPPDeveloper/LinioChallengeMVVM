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
/**
 Main protocol for favorites.
 **/
protocol FavoritesViewModelProtocol: class {
    var items: Observable<[FavoritesSectionModel]> { get }
    var route: Observable<FavoritesViewModelRoute> { get }

    /**
     Functio to request favorites list.
     **/
    func fetchFavorites()

    /**
     Listen when the add product button is tapped.
     **/
    func didTapAddProduct()

    /**
     Listen when select item from collectionView.
     - Parameter item: FavoritesCellViewModelProtocol object.
     **/
    func didSelect(item: FavoritesCellViewModelProtocol)
}

/**
 Protocol for product cell viewModel.
 **/
protocol FavoritesProductCellProtocol: FavoritesCellViewModelProtocol {
    var productImage: Observable<UIImage?> { get }
    var productModel: LinioProduct { get }

    /**
     Request service to get product image.
     **/
    func downloadProductImage()
}

/**
 Protoocl for favorites list cell viewModel.
 **/
protocol FavoritesListCellProtocol: FavoritesCellViewModelProtocol {
    var favoriteListModel: LinioFavoritesList { get }
    var imageWithPath: Observable<ImageIndex?> { get }

    /**
     Begins the download images.
     **/
    func downloadImages()
}

// MARK: - Enums.
enum FavoritesViewModelRoute {
    case addProduct
    case closeLoader
    case fetchFavorites
    case showFavoritesList(list: LinioFavoritesList)
    case showProductDetail(product: LinioProduct, productImage: UIImage?)
}
