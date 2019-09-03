//
//  ProductDetailModels.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/2/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

struct ProductDetailModel {
    let product: LinioProduct
    var productImage: UIImage?
}

struct ProductPriceModel {
    let quantity: Int
    let totalPrice: String
}

struct ProductDetailBadgeStatus {
    let hiddenLinioPlus: Bool
    let hiddenLinioPlus48: Bool
    let hiddenRefurbished: Bool
    let hiddenNew: Bool
    let hiddenAirPlane: Bool
    let hiddenFreeShipping: Bool

    init() {
        hiddenLinioPlus = false
        hiddenLinioPlus48 = false
        hiddenRefurbished = false
        hiddenNew = false
        hiddenAirPlane = false
        hiddenFreeShipping = false
    }

    init(hiddenLinioPlus: Bool, hiddenLinioPlus48: Bool, hiddenRefurbished: Bool, hiddenNew: Bool, hiddenAirPlane: Bool, hiddenFreeShipping: Bool) {
        self.hiddenLinioPlus = hiddenLinioPlus
        self.hiddenLinioPlus48 = hiddenLinioPlus48
        self.hiddenRefurbished = hiddenRefurbished
        self.hiddenNew = hiddenNew
        self.hiddenAirPlane = hiddenAirPlane
        self.hiddenFreeShipping = hiddenFreeShipping
    }
}
