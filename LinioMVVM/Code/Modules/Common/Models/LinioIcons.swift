//
//  LinioIcons.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

enum LinioIcons {
    case none
    case close
    case arrowBack
    case addProduct
    case linioPlus
    case linioPlus48
    case refurbished
    case newProduct
    case airPlaneProduct
    case freeShipping

    var icon: UIImage? {
        switch self {
        case .none:
            return nil
        case .close:
            return UIImage(named: "ndIc48Close600")
        case .arrowBack:
            return UIImage(named: "ndIc48Back600")
        case .addProduct:
            return UIImage(named: "ndIc48AddCollection")
        case .linioPlus:
            return UIImage(named: "ndIc30PlusSquare")
        case .linioPlus48:
            return UIImage(named: "ndIc30Plus48Square")
        case .refurbished:
            return UIImage(named: "ndIc30RefurbishedSquare")
        case .newProduct:
            return UIImage(named: "ndIc30NewSquare")
        case .airPlaneProduct:
            return UIImage(named: "ndIc30InternationalSquare")
        case .freeShipping:
            return UIImage(named: "ndIc30FreeShippingSquare")
        }
    }
}
