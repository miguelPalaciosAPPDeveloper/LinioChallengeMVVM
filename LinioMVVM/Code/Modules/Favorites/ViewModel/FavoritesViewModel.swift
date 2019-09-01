//
//  FavoritesViewModel.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

class FavoritesViewModel {
    // MARK: - Properties.
    let items: Observable<[FavoritesSectionModel]> = Observable([FavoritesSectionModel]())
    let route: Observable<FavoritesViewModelRoute> = Observable(.fetchFavorites)

    private let fetchFavoritesUseCase: FetchFavoritesUseCaseIn
    private let localizables = LinioLocalizables()
    private typealias constants = LinioConstants

    private var favoritesLoadTask: Cancellable? { willSet { favoritesLoadTask?.cancel() } }

    // MARK: - Initialazers.
    init(fetchFavoritesUseCase: FetchFavoritesUseCaseIn) {
        self.fetchFavoritesUseCase = fetchFavoritesUseCase
    }

    // MARK: - Private functions.
    fileprivate func createProductsSection(products: [String: LinioProduct]) -> [FavoritesProductCellViewModel] {
        var productsCells = [FavoritesProductCellViewModel]()
        for (_, product) in products.enumerated() {
            productsCells.append(FavoritesProductCellViewModel(productImage: nil,
                                                               productModel: product.value,
                                                               cellType: .favoriteProducts))
        }
        return productsCells
    }
}

// MARK: - FavoritesViewModelProtocol implementation.
extension FavoritesViewModel: FavoritesViewModelProtocol {
    func fetchFavorites() {
        favoritesLoadTask = fetchFavoritesUseCase.fetchFavorites(path: constants.favoritesPath)
    }

    func didTapAddProduct() {
        route.value = .addProduct
    }

    func didSelect(item: FavoritesCellViewModelProtocol) {
        switch item {
        case let viewModel as FavoritesListCellViewModel:
            route.value = .showFavoritesList(list: viewModel.favoriteListModel)
        case let viewModel as FavoritesProductCellViewModel:
            route.value = .showProductDetail(product: viewModel.productModel,
                                             productImage: viewModel.productImage)
        default:
            break
        }
    }
}


extension FavoritesViewModel: FetchFavoritesUseCaseOut {
    func updateFavorites(_ list: [LinioFavoritesList]) {
        var sections = [FavoritesSectionModel]()
        let listCells = list.map({ FavoritesListCellViewModel(firtsProducts: [],
                                                              favoriteListModel: $0,
                                                              cellType: .favoriteList) })
        let productsCells = list
            .flatMap({ $0.products })
            .map({ FavoritesProductCellViewModel(productImage: nil,
                                                 productModel: $1,
                                                 cellType: .favoriteProducts) })

        var title: String? = nil
        sections.append(FavoritesSectionModel(title: title,
                                              headerSize: constants.listCellHeaderSize,
                                              cells: listCells))
        title = String(format: localizables.favoritesProductsHeaderTitle, productsCells.count)
        sections.append(FavoritesSectionModel(title: title,
                                              headerSize: constants.productCellHeaderSize,
                                              cells: productsCells))
        items.value = sections
        route.value = .closeLoader
    }

    func failure(_ message: String) {
        // TODO: Add alert or custom toast.
    }
}
