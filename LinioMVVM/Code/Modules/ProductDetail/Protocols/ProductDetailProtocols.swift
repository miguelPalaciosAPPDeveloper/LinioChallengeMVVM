//
//  ProductDetailProtocols.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/2/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols.
protocol ProductDetailViewModelProtocol {
    var productImage: Observable<UIImage?> { get }
    var productName: Observable<String> { get }
    var productBadgeStatus: Observable<ProductDetailBadgeStatus> { get }
    var productPriceModel: Observable<ProductPriceModel> { get }
    var route: Observable<ProductDetailViewModelRoute> { get }

    /**
     First function to execute.
     **/
    func didLoad()

    /**
     Change the quantity product (minimun 1).
     - Parameter action: minus o plus one product.
     **/
    func changeProductQuantity(action: ProductQuantityAction)
}

// MARK: - Enums.
enum ProductDetailViewModelRoute {
    case didLoad
    case closeLoader
}

enum ProductQuantityAction: Int {
    case plusProduct = 1
    case minusProduct = -1
}
