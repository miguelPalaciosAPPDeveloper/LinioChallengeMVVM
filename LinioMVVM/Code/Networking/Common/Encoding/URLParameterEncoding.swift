//
//  URLParameterEncoding.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

/**
 Struct to validate parameters.
 **/
struct URLParameterEncoding: ParameterEncoder {
    typealias constants = ServicesConstants

    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw ServicesResponseError.missingURL }
        
        let value = parameters.replacingOccurrences(of: url.absoluteString, with: "")

        guard !parameters.isEmpty, !value.isEmpty else { throw ServicesResponseError.fileNotFound }
        let urlString = "\(url.absoluteString)\(value)"

        if urlRequest.value(forHTTPHeaderField: constants.contenTypeKey) == nil {
            urlRequest.setValue(constants.urlEncodeHeader, forHTTPHeaderField: constants.contenTypeKey)
        }

        guard let newURL = URL(string: urlString) else { throw ServicesResponseError.encodingFailed }
        urlRequest.url = newURL
    }
}
