//
//  ServicesRouter.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/30/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<Responser: ServicesResponseHandler>(_ endPoint: EndPoint, responseHandler: Responser) -> Cancellable?
}

/**
 Router to request with ServicesRouter implementation.
 **/
class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?

    func request<Responser>(_ endPoint: EndPoint, responseHandler: Responser) -> Cancellable? where Responser: ServicesResponseHandler {
        let session = URLSession.shared
        do {
            let request = try self.createRequest(from: endPoint)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let responseError = error {
                    responseHandler.verifyFailureRequest(error: responseError)
                } else if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        responseHandler.verifySuccessRequest(data: data)
                    case 401...500:
                        responseHandler.verifyFailureRequest(error: ServicesResponseError.authenticationError)
                    case 501...599:
                        responseHandler.verifyFailureRequest(error: ServicesResponseError.badRequest)
                    default:
                        responseHandler.verifyFailureRequest(error: ServicesResponseError.serverError)
                    }
                }

                responseHandler.verifySuccessRequest(data: data)
            })
        } catch {
            responseHandler.verifyFailureRequest(error: error)
        }

        task?.resume()
        return task
    }

    fileprivate func createRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        switch route.task {
        case .request(let path), .downloadImage(let path):
            do {
                try URLParameterEncoding.encode(urlRequest: &request, with: path)
            } catch {
                throw error
            }
        }
        return request
    }
}

// MARK: - Cancellable implementation.
extension URLSessionTask: Cancellable {}
