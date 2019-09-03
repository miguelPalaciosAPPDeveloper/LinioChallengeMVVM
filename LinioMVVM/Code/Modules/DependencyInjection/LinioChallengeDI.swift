//
//  LinioChallengeDI.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

class LinioChallengeDI {
    /**
     Create favorites module injection.
     - Returns: FavoritesViewController.
     **/
    class func createFavoritesModule() -> FavoritesViewController {
        // Connection.
        let view = FavoritesViewController.createInstance()
        let serviceRouter = Router<LinioChallengeEndPoint>()

        // Repositories.
        let favoritesRepository: FavoritesRepositoryProtocol = FavoritesRepository(serviceRouter: serviceRouter)
        let imageRepository: ProductImageRepositoryProtocol = ProductImageRepository(serviceRouter: serviceRouter)
        let imageCacheRepository: ProductImageCacheRepositoryProtocol = ProductImageCacheRepository()

        // UseCases
        var fetchFavoritesUseCase: FetchFavoritesUseCaseProtocol = FetchFavoritesUseCase(favoritesRepository: favoritesRepository)
        let productImageUseCase: ProductImageUseCaseProtocol = ProductImageUseCase(imageRepository: imageRepository, imageCacheRespository: imageCacheRepository)

        // ViewModel
        let viewModel: FavoritesViewModelProtocol & FetchFavoritesUseCaseOutput = FavoritesViewModel(fetchFavoritesUseCase: fetchFavoritesUseCase, productImageUseCase: productImageUseCase)
        fetchFavoritesUseCase.useCaseOutput = viewModel
        view.viewModel = viewModel
        return view
    }

    /**
     Create product detail module injection.
     - Returns: ProductDetailViewController.
     **/
    class func createProductDetailModule(model: ProductDetailModel) -> ProductDetailViewController {
        // Connection.
        let view = ProductDetailViewController.createInstance()
        let serviceRouter = Router<LinioChallengeEndPoint>()

        // Repositories.
        let imageRepository: ProductImageRepositoryProtocol = ProductImageRepository(serviceRouter: serviceRouter)
        let imageCacheRepository: ProductImageCacheRepositoryProtocol = ProductImageCacheRepository()

        // UseCases
        let productImageUseCase: ProductImageUseCaseProtocol = ProductImageUseCase(imageRepository: imageRepository, imageCacheRespository: imageCacheRepository)

        // ViewModel
        let viewModel: ProductDetailViewModelProtocol = ProductDetailViewModel(detailModel: model, productImageUseCase: productImageUseCase)
        view.viewModel = viewModel
        return view
    }
}
