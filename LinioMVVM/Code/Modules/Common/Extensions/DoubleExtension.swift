//
//  DoubleExtension.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/2/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

extension Double {
    func amountFormat() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
