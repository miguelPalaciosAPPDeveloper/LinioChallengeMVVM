//
//  FavoritesViewController.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, InstantiableViewController {

    // MARK: - IBOutlets.
    @IBOutlet weak var favoritesCollectionView: UICollectionView!

    // MARK: - Properties
    static var storyboardFileName: String = "Favorites"
    private let localizables = LinioLocalizables()
    private typealias constants = LinioConstants

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setup(title: localizables.favoritesNavigationTitle, leftIcon: .addProduct, leftSelector: #selector(addProduct), target: self)
    }

    // MARK: - Private functions.
    @objc fileprivate func addProduct() {
        // TODO: Add logic.
    }

    fileprivate func setupCollectionView() {
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.contentInset = constants.defaultInset

        favoritesCollectionView.register(FavoritesListViewCell.nib,
                                         forCellWithReuseIdentifier: FavoritesListViewCell.identifier)
        favoritesCollectionView.register(ProductViewCell.nib,
                                         forCellWithReuseIdentifier: ProductViewCell.identifier)
        favoritesCollectionView.register(FavoriteHeaderReusableView.nib,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: FavoriteHeaderReusableView.identifier)
    }
}

// MARK: - UICollectionViewDelegates implementation.
extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return constants.cellPadding
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: constants.cellWidth, height: constants.cellHeight)
    }
}
