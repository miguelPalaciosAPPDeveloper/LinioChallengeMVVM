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
    case jsonMapping(String)
    case authenticationError
    case badRequest
    case serverError
    case native(Swift.Error?)
}
