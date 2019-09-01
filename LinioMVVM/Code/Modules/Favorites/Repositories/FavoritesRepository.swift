//
//  FavoritesRepository.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

protocol FavoritesRepositoryProtocol {
    @discardableResult
    func fetchFavorites(path: String, completion: @escaping ServicesRouterCompletion<[LinioFavoritesList]>) -> Cancellable?
}

class FavoritesRepository: FavoritesRepositoryProtocol {
    private let serviceManager: LinioChallengeServiceManager

    init(serviceRouter: Router<LinioChallengeEndPoint>) {
        self.serviceManager = LinioChallengeServiceManager(router: serviceRouter)
    }

    func fetchFavorites(path: String, completion: @escaping ServicesRouterCompletion<[LinioFavoritesList]>) -> Cancellable? {
        return serviceManager.getFavoritesList(withPath: path, completion: completion)
    }
}
