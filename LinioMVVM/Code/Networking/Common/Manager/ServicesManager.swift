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

enum ServicesResult<T> {
    case success(T)
    case failure(ServicesResponseError)
}

// MARK: - Example.
protocol LinioManagerProtocol: ServicesManager {
    func getFavorites()
}
enum LinioChallengeEndPoint: EndPointType {

    case favorites

    var baseURL: URL {
        return URL(fileReferenceLiteralResourceName: "")
    }

    var path: String {
        return ""
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return .downloadImage(urlParameters: "")
    }
}

struct LinioRequest: LinioManagerProtocol {
    typealias EndPoint = LinioChallengeEndPoint

    let router: Router<EndPoint>

    func getFavorites() {
    }
}

class pruebas {
    private var manager = LinioRequest(router: MockRouter<LinioChallengeEndPoint>())

    func callService() {
        manager.getFavorites()
    }
}

class MockRouter<EndPoint: EndPointType> : Router<EndPoint> {
    override func request<Responser>(_ endPoint: EndPoint, responseHandler: Responser) where Responser : ServicesResponseHandler {
    }
}
