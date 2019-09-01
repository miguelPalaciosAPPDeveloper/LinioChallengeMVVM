//
//  ProductImageCacheRepository.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

protocol ProductImageCacheRepositoryProtocol {
    func saveImage(image: UIImage, imageUrl: String)

    func getImageInCache(imageUrl: String) -> UIImage?
}

class ProductImageCacheRepository: ProductImageCacheRepositoryProtocol {
    private let imageCache = NSCache<NSString, UIImage>()

    func saveImage(image: UIImage, imageUrl: String) {
        DispatchQueue.main.async {
            self.imageCache.setObject(image, forKey: NSString(string: imageUrl))
        }
    }

    func getImageInCache(imageUrl: String) -> UIImage? {
        let image = imageCache.object(forKey: NSString(string: imageUrl))
        return image
    }
}
