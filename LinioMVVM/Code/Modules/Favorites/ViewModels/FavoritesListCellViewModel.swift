//
//  FavoritesListCellViewModel.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

class FavoritesListViewCellViewModel: FavoritesListCellProtocol {
    // MARK: - Protocols properties.
    let favoriteListModel: LinioFavoritesList
    let cellType: FavoriteCellType = .favoriteList
    var imageWithPath: Observable<ImageIndex?> = Observable(nil)

    private var productImagePath: String?
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }
    private let productImageUseCase: ProductImageUseCaseProtocol
    private var firstProducts = [LinioProduct]()

    init(favoriteListModel: LinioFavoritesList, productImageUseCase: ProductImageUseCaseProtocol) {
        self.favoriteListModel = favoriteListModel
        self.productImageUseCase = productImageUseCase
        self.firstProducts = Array(favoriteListModel.products.compactMap({ $1 }).prefix(upTo: 3))
        self.productImagePath = firstProducts.first?.image
    }

    func downloadImages() {
        guard firstProducts.count > 0 else { return }
        downloadProductImage(index: 0)
    }

    /**
     Updated index to dowunload next image.
     - Parameter index: index for next image.
     **/
    fileprivate func downloadNextImage(index: Int) {
        guard index < firstProducts.count - 1 else { return }
        let newIndex = index + 1
        self.productImagePath = self.firstProducts[newIndex].image
        downloadProductImage(index: newIndex)
    }

    /**
     Download product image.
     - Parameter index: index to set new imageIndex model.
     **/
    fileprivate func downloadProductImage(index: Int) {
        guard let productImagePath = productImagePath else { return }
        imageLoadTask = productImageUseCase.downloadProductImage(path: productImagePath) { [weak self] (result) in
            guard self?.productImagePath == productImagePath else { return }
            switch result {
            case .success(let image):
                self?.productImageUseCase.saveImage(image: image, imageUrl: productImagePath)
                self?.imageWithPath.value = ImageIndex(index: index, image: image)
                self?.downloadNextImage(index: index)
            case .failure: break
            }
        }
    }
}
