//
//  HTTPEnums.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

/**
 Header type.
 **/
typealias HTTPHeaders = [String: String]

/**
 Parameters type.
 **/
typealias Parameters = String


/**
 HTTPMethod for this challenge.
 **/
enum HTTPMethod: String {
    case get    = "GET"
}

/**
 Task type for this challenge.
 **/
enum HTTPTask {
    case request(urlParameters: String)
    case downloadImage(urlParameters: String)
}
