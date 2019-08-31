//
//  ServicesResponseHandler.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

typealias ServicesRouterCompletion<T> = (ServicesResult<T>) -> Void

/**
 Handler to request reponse.
 **/
protocol ServicesResponseHandler {
    associatedtype ResponseType

    var completionClosure: ServicesRouterCompletion<ResponseType> { get }

    func verifySuccessRequest(data: Data?)

    func verifyFailureRequest(error: Error)
}
