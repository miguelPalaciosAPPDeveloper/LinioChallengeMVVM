//
//  ProductDetailViewModel.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/2/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

class ProductDetailViewModel {
    // MARK: - Properties.
    let productImage: Observable<UIImage?> = Observable(nil)
    let productName: Observable<String> = Observable("")
    let productBadgeStatus: Observable<ProductDetailBadgeStatus> = Observable(ProductDetailBadgeStatus())
    let productPriceModel: Observable<ProductPriceModel> = Observable(ProductPriceModel(quantity: 1,
                                                                                        totalPrice: ""))
    let route: Observable<ProductDetailViewModelRoute> = Observable(.didLoad)

    private var detailModel: ProductDetailModel
    private let productImageUseCase: ProductImageUseCaseProtocol
    private var imageLoadTask: Cancellable? { willSet { imageLoadTask?.cancel() } }

    init(detailModel: ProductDetailModel, productImageUseCase: ProductImageUseCaseProtocol) {
        self.detailModel = detailModel
        self.productImageUseCase = productImageUseCase
    }

    // MARK: - Private functions.
    /**
     Change the quantity product (minimun 1).
     - Parameter value: minus o plus one product.
     **/
    fileprivate func updateProductPriceAndQuantity(value: Int) {
        let price = detailModel.product.wishListPrice
        let newQuantity = productPriceModel.value.quantity + value

        guard newQuantity >= 1 else { return }
        let totalPrice = price * Double(newQuantity)
        self.productPriceModel.value = ProductPriceModel(quantity: newQuantity,
                                                         totalPrice: totalPrice.amountFormat())
    }

    /**
     Setup view, this functions is execute one time.
     - Parameter image: product image from favorites or service.
     **/
    fileprivate func setupView(_ image: UIImage?) {
        let price = detailModel.product.wishListPrice.amountFormat()
        self.productImage.value = image
        self.productName.value = detailModel.product.name
        self.productPriceModel.value = ProductPriceModel(quantity: 1,
                                                         totalPrice: price)
        self.setBadgeStatus()
        self.route.value = .closeLoader
    }

    /**
     Download the product image if necessary.
     - Parameter path: image url to download.
     **/
    fileprivate func downloadProductImage(path: String) {
        imageLoadTask = productImageUseCase.downloadProductImage(path: path) { [weak self] (result) in
            switch result {
            case .success(let image):
                self?.setupView(image)
            case .failure:
                self?.setupView(nil)
            }
        }
    }

    /**
     Create an array bolean for badges satus.
     - Returns: array with bolean status.
     **/
    fileprivate func setBadgeStatus(){
        let product = detailModel.product
        let isPlus = product.linioPlusLevel == 1
        let isPlus48 = product.linioPlusLevel == 2
        let productState = ProductStateType(rawValue: product.conditionType) ?? .new

        let model = ProductDetailBadgeStatus(hiddenLinioPlus: !isPlus,
                                             hiddenLinioPlus48: !isPlus48,
                                             hiddenRefurbished: productState == .new,
                                             hiddenNew: productState == .refurbished,
                                             hiddenAirPlane: !product.imported,
                                             hiddenFreeShipping: !product.freeShipping)
        self.productBadgeStatus.value = model
    }
}

// MARK: - ProductDetailViewModelProtocol implementation.
extension ProductDetailViewModel: ProductDetailViewModelProtocol {
    func didLoad() {
        guard let image = detailModel.productImage else {
            self.downloadProductImage(path: detailModel.product.image)
            return
        }
        self.setupView(image)
    }

    func changeProductQuantity(action: ProductQuantityAction) {
        self.updateProductPriceAndQuantity(value: action.rawValue)
    }
}
