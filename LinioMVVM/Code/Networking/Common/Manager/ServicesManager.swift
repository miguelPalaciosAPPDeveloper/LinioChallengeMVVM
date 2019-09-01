//
//  ServicesManager.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

protocol ServicesManager {
    associatedtype EndPoint: EndPointType
    var router: Router<EndPoint> { get }
}

protocol Cancellable {
    func cancel()
}

enum ServicesResult<T> {
    case success(T)
    case failure(ServicesResponseError)
}
