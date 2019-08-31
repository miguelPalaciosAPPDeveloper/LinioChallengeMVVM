//
//  LinioChallengeEndPoint.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

enum LinioChallengeEndPoint {
    case favorites(path: String)
    case productImage(path: String)
}

extension LinioChallengeEndPoint: EndPointType {
    var baseURL: URL {
        switch self {
        case .favorites:
            guard let url = URL(string: "https://gist.githubusercontent.com/egteja/") else { fatalError("baseURL could not be configured.")}
            return url
        case .productImage:
            guard let url = URL(string: "https://i.linio.com/p/") else { fatalError("baseURL could not be configured.")}
            return url
        }
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        switch self {
        case .favorites(let path):
            return .request(path: path)
        case .productImage(let path):
            return .downloadImage(path: path)
        }
    }

}
