//
//  LinioChallengeImageProductRH.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

class LinioChallengeImageProductRH: ServicesResponseHandler {
    // MARK: - ResponseType
    typealias ResponseType = UIImage

    // MARK: - completionClosure.
    var completionClosure: (ServicesResult<ResponseType>) -> Void

    // MARK: - Private properties.
    private lazy var errorValidator = ServicesErrorValidator()

    // MARK: - Initializers
    init(withCompletion completionClosure: @escaping ServicesRouterCompletion<ResponseType>) {
        self.completionClosure = completionClosure
    }

    func verifySuccessRequest(data: Data?) {
        do {
            guard let JSONObject = data else {
                throw ServicesResponseError.fileNotFound
            }

            guard let image = UIImage(data: JSONObject) else {
                throw ServicesResponseError.fileNotFound
            }

            completionClosure(.success(image))
        } catch let serviceError as ServicesResponseError {
            completionClosure(.failure(serviceError))
        } catch {
            completionClosure(.failure(.serverError))
        }
    }

    func verifyFailureRequest(error: Error) {
        let responseError = errorValidator.validateError(error)
        completionClosure(.failure(responseError))
    }
}
