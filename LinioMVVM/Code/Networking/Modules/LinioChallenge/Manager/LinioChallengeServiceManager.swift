//
//  LinioChallengeServiceManager.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

protocol LinioChallengeServiceProtocol: ServicesManager {
    @discardableResult
    func getFavoritesList(withPath jsonPath: String,
                          completion: @escaping ServicesRouterCompletion<[LinioFavoritesList]>) -> Cancellable?
    @discardableResult
    func getImageProduct(withPath imagePath: String,
                         completion: @escaping ServicesRouterCompletion<UIImage>) -> Cancellable?
}

struct LinioChallengeServiceManager: LinioChallengeServiceProtocol {
    typealias EndPoint = LinioChallengeEndPoint

    var router: Router<LinioChallengeEndPoint>

    func getFavoritesList(withPath jsonPath: String, completion: @escaping ServicesRouterCompletion<[LinioFavoritesList]>) -> Cancellable? {
        let responseHandler = LinioChallengeFavoritesRH(withCompletion: completion)
        return router.request(.favorites(path: jsonPath), responseHandler: responseHandler)
    }

    func getImageProduct(withPath imagePath: String, completion: @escaping ServicesRouterCompletion<UIImage>) -> Cancellable? {
        let responseHandler = LinioChallengeImageProductRH(withCompletion: completion)
        return router.request(.productImage(path: imagePath), responseHandler: responseHandler)
    }
}
