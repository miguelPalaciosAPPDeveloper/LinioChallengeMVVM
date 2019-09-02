//
//  ProductImageUseCase.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

/**
 Use case to downlaod product image and save into Cache.
 **/
protocol ProductImageUseCaseProtocol {
    var imageRepository: ProductImageRepositoryProtocol { get }
    var imageCacheRespository: ProductImageCacheRepositoryProtocol { get }

    func downloadProductImage(path: String, completion: @escaping ServicesRouterCompletion<UIImage>) -> Cancellable?

    func saveImage(image: UIImage, imageUrl: String)
}

class ProductImageUseCase: ProductImageUseCaseProtocol {
    let imageRepository: ProductImageRepositoryProtocol
    let imageCacheRespository: ProductImageCacheRepositoryProtocol

    init(imageRepository: ProductImageRepositoryProtocol, imageCacheRespository: ProductImageCacheRepositoryProtocol) {
        self.imageRepository = imageRepository
        self.imageCacheRespository = imageCacheRespository
    }

    func downloadProductImage(path: String, completion: @escaping ServicesRouterCompletion<UIImage>) -> Cancellable? {
        guard let image = imageCacheRespository.getImageInCache(imageUrl: path) else {
            return imageRepository.downloadProductImage(path: path, completion: completion)
        }
        completion(.success(image))
        return nil
    }

    func saveImage(image: UIImage, imageUrl: String) {
        imageCacheRespository.saveImage(image: image, imageUrl: imageUrl)
    }
}
