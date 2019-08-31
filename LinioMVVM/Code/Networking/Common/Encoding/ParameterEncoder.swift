//
//  ParameterEncoder.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

/**
 Protocol for encoder.
 **/
protocol ParameterEncoder {
    /**
     Function to encode parameters.
     - Parameter urlRequest: value with basic information.
     - Parameter parameters: parameters to request.
     **/
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
