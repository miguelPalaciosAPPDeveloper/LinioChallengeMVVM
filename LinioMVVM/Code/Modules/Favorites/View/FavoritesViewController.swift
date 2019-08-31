//
//  FavoritesViewController.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, InstantiableViewController {
    // MARK: - Properties
    static var storyboardFileName: String = "Favorites"
    private let localizables = LinioLocalizables()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setup(title: localizables.favoritesNavigationTitle, leftIcon: .addProduct, leftSelector: #selector(addProduct), target: self)
    }

    // MARK: - Private functions.
    @objc fileprivate func addProduct() {
        // TODO: Add logic.
    }
}
