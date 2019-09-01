//
//  ProductImageRepository.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

protocol ProductImageRepositoryProtocol {
    @discardableResult
    func downloadProductImage(path: String, completion: @escaping ServicesRouterCompletion<UIImage>) -> Cancellable?
}

class ProductImageRepository: ProductImageRepositoryProtocol {
    private let serviceManager: LinioChallengeServiceManager

    init(serviceRouter: Router<LinioChallengeEndPoint>) {
        self.serviceManager = LinioChallengeServiceManager(router: serviceRouter)
    }

    func downloadProductImage(path: String, completion: @escaping ServicesRouterCompletion<UIImage>) -> Cancellable? {
        return serviceManager.getImageProduct(withPath: path, completion: completion)
    }
}

