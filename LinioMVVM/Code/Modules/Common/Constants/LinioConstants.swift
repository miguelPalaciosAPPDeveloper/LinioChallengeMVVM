//
//  LinioConstants.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

enum LinioConstants {
    // MARK: - Constraints constants.
    static let defaultValue: CGFloat = 108
    static let highPriority: UILayoutPriority = UILayoutPriority(rawValue: 100)

    // MARK: - Shadow constants.
    static let radius: CGFloat = 4.0
    static let shadowOpacity: Float = 0.6
    static let shadowColor = UIColor(red: 0.0 / 255.0,
                                     green: 45.0 / 255.0,
                                     blue: 114.0 / 255.0,
                                     alpha: 0.15)

    // MARK: - Favorites.
    private static let screen = UIScreen.main.bounds
    static let cellPadding: CGFloat = screen.width * 0.024
    static let cellHeight: CGFloat = screen.height * 0.2668
    static let cellWidth: CGFloat = screen.width * 0.464
    static let defaultInset = UIEdgeInsets(top: 0.0,
                                           left: cellPadding,
                                           bottom: 0.0,
                                           right: cellPadding)
}
