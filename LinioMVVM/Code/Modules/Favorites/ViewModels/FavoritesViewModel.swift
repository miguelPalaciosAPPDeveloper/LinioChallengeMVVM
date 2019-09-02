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

    private let productImageUseCase: ProductImageUseCaseProtocol
    private let fetchFavoritesUseCase: FetchFavoritesUseCaseProtocol
    private let localizables = LinioLocalizables()
    private typealias constants = LinioConstants

    private var favoritesLoadTask: Cancellable? { willSet { favoritesLoadTask?.cancel() } }

    // MARK: - Initialazers.
    init(fetchFavoritesUseCase: FetchFavoritesUseCaseProtocol, productImageUseCase: ProductImageUseCaseProtocol) {
        self.fetchFavoritesUseCase = fetchFavoritesUseCase
        self.productImageUseCase = productImageUseCase
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
        case let viewModel as FavoritesListViewCellViewModel:
            route.value = .showFavoritesList(list: viewModel.favoriteListModel)
        case let viewModel as FavoritesProductCellViewModel:
            route.value = .showProductDetail(product: viewModel.productModel,
                                             productImage: viewModel.productImage.value)
        default:
            break
        }
    }
}


extension FavoritesViewModel: FetchFavoritesUseCaseOutput {
    func updateFavorites(_ list: [LinioFavoritesList]) {
        var sections = [FavoritesSectionModel]()
        let listCells = list.map({
            FavoritesListViewCellViewModel(favoriteListModel: $0,
                                           productImageUseCase: self.productImageUseCase)
        })

        let productsCells = list
            .flatMap({ $0.products })
            .map({ FavoritesProductCellViewModel(productModel: $1,
                                                 productImageUseCase: self.productImageUseCase) })

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
