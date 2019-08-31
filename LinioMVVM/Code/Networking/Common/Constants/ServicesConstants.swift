//
//  ServicesConstants.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

/**
 Constants values for network layer.
 **/
enum ServicesConstants {
    static let contenTypeKey = "Content-Type"
    static let urlEncodeHeader = "application/x-www-form-urlencoded; charset=utf-8"

    // MARK: - Error messages
    static let parameters = "parameters are empty"
    static let encodingFailed = "Parameter encoding failed"
    static let fileNotFound = "File not found"
    static let missingURL = "URL is nil"
    static let genericError = "We lost contact with the server"
    static let notNetworkConnection = "No internet connection"
    static let timeout = "Timeout"
    static let authentication = "This request needs authentication"
    static let badRequest = "Bad request"
}
