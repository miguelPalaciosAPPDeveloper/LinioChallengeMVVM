//
//  FavoritesProductCellViewModel.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

/**
 ViewModel for products cells.
 **/
class FavoritesProductCellViewModel: FavoritesProductCellProtocol {
    // MARK: - Protocols properties.
    let productImage: Observable<UIImage?> = Observable(nil)
    let productModel: LinioProduct
    let cellType: FavoriteCellType = .favoriteProducts

    // MARK: - General properties.
    private var productImagePath: String?
    private var productImageUseCase: ProductImageUseCaseProtocol
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    init(productModel: LinioProduct, productImageUseCase: ProductImageUseCaseProtocol) {
        self.productModel = productModel
        self.productImageUseCase = productImageUseCase
        self.productImagePath = productModel.image
    }

    func downloadProductImage() {
        productImage.value = nil
        guard let productImagePath = self.productImagePath else { return }
        imageLoadTask = productImageUseCase.downloadProductImage(path: productImagePath, completion: { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.productImageUseCase.saveImage(image: image, imageUrl: productImagePath)
                self?.productImage.value = image
            case .failure: break
            }
        })
    }
}
