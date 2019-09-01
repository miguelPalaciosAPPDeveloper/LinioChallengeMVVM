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
        let view = FavoritesViewController.createInstance()
        let serviceRouter = Router<LinioChallengeEndPoint>()
        let favoritesRepository: FavoritesRepositoryProtocol = FavoritesRepository(serviceRouter: serviceRouter)
        var fetchFavoritesUseCase: FetchFavoritesUseCaseIn = FetchFavoritesUseCase(favoritesRepository: favoritesRepository)
        let viewModel: FavoritesViewModelProtocol & FetchFavoritesUseCaseOut = FavoritesViewModel(fetchFavoritesUseCase: fetchFavoritesUseCase)
        fetchFavoritesUseCase.useCaseOut = viewModel
        view.viewModel = viewModel
        return view
    }
}
