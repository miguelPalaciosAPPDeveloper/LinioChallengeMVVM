//
//  InstantiableViewController.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation
import UIKit

/**
 Protocol to create new instance of UIViewController.
 **/
protocol InstantiableViewController: class {
    static var storyboardFileName: String { get }
}

extension InstantiableViewController {
    static var storyboardId: String {
        return String(describing: self)
    }
}

extension InstantiableViewController where Self: UIViewController {
    static func createInstance() -> Self {
        let fileName = Self.storyboardFileName
        let storyboard = UIStoryboard(name: fileName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: self.storyboardId) as? Self else {
            fatalError("The viewController '\(self.storyboardId)' not exist")
        }
        return viewController
    }
}
