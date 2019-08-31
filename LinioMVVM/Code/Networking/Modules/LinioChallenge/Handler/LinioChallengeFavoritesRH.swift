//
//  LinioChallengeFavoritesRH.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

class LinioChallengeFavoritesRH: ServicesResponseHandler {
    // MARK: - ResponseType
    typealias ResponseType = [LinioFavoritesList]

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

            let model = try JSONDecoder().decode(ResponseType.self, from: JSONObject)

            completionClosure(.success(model))
        } catch let serviceError as ServicesResponseError {
            completionClosure(.failure(serviceError))
        } catch let error as DecodingError {
            let badResponse: ServicesResponseError = .badResponse(error.localizedDescription)
            completionClosure(.failure(badResponse))
        } catch {
            completionClosure(.failure(.serverError))
        }
    }

    func verifyFailureRequest(error: Error) {
        let responseError = errorValidator.validateError(error)
        completionClosure(.failure(responseError))
    }
}
