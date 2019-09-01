//
//  FetchFavoritesUseCase.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

protocol FetchFavoritesUseCaseIn {
    var favoritesRepository: FavoritesRepositoryProtocol { get }
    var useCaseOut: FetchFavoritesUseCaseOut? { get set }

    @discardableResult
    func fetchFavorites(path: String) -> Cancellable?
}

protocol FetchFavoritesUseCaseOut {
    func updateFavorites(_ list: [LinioFavoritesList])
    func failure(_ message: String)
}

class FetchFavoritesUseCase: FetchFavoritesUseCaseIn {
    let favoritesRepository: FavoritesRepositoryProtocol
    var useCaseOut: FetchFavoritesUseCaseOut?

    init(favoritesRepository: FavoritesRepositoryProtocol) {
        self.favoritesRepository = favoritesRepository
    }

    func fetchFavorites(path: String) -> Cancellable? {
        return favoritesRepository.fetchFavorites(path: path) { (result) in
            switch result {
            case .success(let response):
                self.useCaseOut?.updateFavorites(response)
            case .failure(let error):
                self.useCaseOut?.failure(error.errorMessage)
            }
        }
    }
}
