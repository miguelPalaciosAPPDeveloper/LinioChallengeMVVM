//
//  FetchFavoritesUseCase.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

/**
 Use case to fetch favorites lists.
 **/
protocol FetchFavoritesUseCaseProtocol {
    var favoritesRepository: FavoritesRepositoryProtocol { get }
    var useCaseOutput: FetchFavoritesUseCaseOutput? { get set }

    @discardableResult
    func fetchFavorites(path: String) -> Cancellable?
}

protocol FetchFavoritesUseCaseOutput {
    func updateFavorites(_ list: [LinioFavoritesList])
    func failure(_ message: String)
}

class FetchFavoritesUseCase: FetchFavoritesUseCaseProtocol {
    let favoritesRepository: FavoritesRepositoryProtocol
    var useCaseOutput: FetchFavoritesUseCaseOutput?

    init(favoritesRepository: FavoritesRepositoryProtocol) {
        self.favoritesRepository = favoritesRepository
    }

    func fetchFavorites(path: String) -> Cancellable? {
        return favoritesRepository.fetchFavorites(path: path) { (result) in
            switch result {
            case .success(let response):
                self.useCaseOutput?.updateFavorites(response)
            case .failure(let error):
                self.useCaseOutput?.failure(error.errorMessage)
            }
        }
    }
}
