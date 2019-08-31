//
//  ServicesErrorValidator.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

/**
 Validate error type.
 **/
struct ServicesErrorValidator {
    func validateError(_ error: Error?) -> ServicesResponseError {
        guard let requestError = error else { return ServicesResponseError.native(error) }

        switch requestError._code {
        case NSURLErrorTimedOut:
            return ServicesResponseError.timeout
        case NSURLErrorNotConnectedToInternet:
            return ServicesResponseError.notNetworkConnection
        default:
            return ServicesResponseError.native(error)
        }
    }
}


/**
 Posibles errors.
 **/
enum ServicesResponseError: Error {
    case parameters
    case encodingFailed
    case fileNotFound
    case missingURL
    case notNetworkConnection
    case timeout
    case authenticationError
    case badRequest
    case badResponse(String)
    case serverError
    case native(Swift.Error?)

    var errorMessage: String {
        switch self {
        case .parameters:
            return ServicesConstants.parameters
        case .encodingFailed:
            return ServicesConstants.encodingFailed
        case .fileNotFound:
            return ServicesConstants.fileNotFound
        case .missingURL:
            return ServicesConstants.missingURL
        case .notNetworkConnection:
            return ServicesConstants.notNetworkConnection
        case .timeout:
            return ServicesConstants.timeout
        case .authenticationError:
            return ServicesConstants.authentication
        case .badRequest:
            return ServicesConstants.badRequest
        case .badResponse(let message):
            return message
        case .serverError:
            return ServicesConstants.genericError
        case .native(let error):
            return String(describing: error?.localizedDescription)
        }
    }
}
