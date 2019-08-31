//
//  UICollectionReusableViewExtension.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

extension UICollectionReusableView {
    /**
     Create nib for the cell.
     **/
    class var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: classForCoder()))
    }

    /**
     Reusble cell identifier.
     **/
    class var identifier: String {
        return String(describing: self)
    }
}
