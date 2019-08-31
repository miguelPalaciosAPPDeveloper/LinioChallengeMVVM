//
//  EndPointType.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
}
