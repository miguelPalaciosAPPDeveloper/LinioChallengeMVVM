//
//  FavoritesViewController.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, InstantiableViewController, AnimationLoadable {

    // MARK: - IBOutlets.
    @IBOutlet weak var favoritesCollectionView: UICollectionView!

    // MARK: - Properties
    static var storyboardFileName: String = "Favorites"
    private let localizables = LinioLocalizables()
    private typealias constants = LinioConstants
    private var items = [FavoritesSectionModel]()
    var viewModel: FavoritesViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setup(title: localizables.favoritesNavigationTitle,
                                         leftIcon: .addProduct,
                                         leftSelector: #selector(addProduct),
                                         target: self)
        self.setupCollectionView()
        guard let viewModel = self.viewModel else { return }
        self.bind(to: viewModel)
        self.startAnimation(animation: LinioAnimations.loader) { [weak self] in
            self?.viewModel?.fetchFavorites()
        }
    }

    // MARK: - Private functions.
    @objc fileprivate func addProduct() {
        viewModel?.didTapAddProduct()
    }

    /**
     Setup collectionView, assign delegates and register cells.
     **/
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

    /**
     Add observes to viewModel.
     **/
    fileprivate func bind(to viewModel: FavoritesViewModelProtocol) {
        viewModel.items.observe(on: self) { [weak self] (items) in
            self?.items = items
        }

        viewModel.route.observe(on: self) { [weak self] (route) in
            self?.handler(route)
        }
    }

    fileprivate func handler(_ route: FavoritesViewModelRoute) {
        switch route {
        case .addProduct:
            // TODO: Add view.
            self.showNativeAlert(message: localizables.favoritesAddProductAlertMessage)
        case .closeLoader:
            self.stopAnimation { self.favoritesCollectionView.reloadData() }
        case .showFavoritesList(_):
            // TODO: Add view.
            self.showNativeAlert(message: localizables.favoritesListItemAlertMessage)
        case .showProductDetail(let product, let productImage):
            let model = ProductDetailModel(product: product, productImage: productImage)
            let viewController = LinioChallengeDI.createProductDetailModule(model: model)
            self.present(viewController, animated: true, completion: nil)
        default:
            break
        }
    }

    /**
     Show alert with feature message.
     **/
    fileprivate func showNativeAlert(message: String) {
        let alert = UIAlertController(title: localizables.favoritesAlertTitle,
                                      message: message,
                                      preferredStyle: .alert)

        let acceptAction = UIAlertAction(title: localizables.favoritesAcceptButtonTitle,
                                         style: .default,
                                         handler: nil)
        alert.addAction(acceptAction)
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegates implementation.
extension FavoritesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellViewModel = items[indexPath.section].cells[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellType.identifer,
                                                      for: indexPath)

        if let favoritesCell = cell as? FavoritesCellProtocol { favoritesCell.setup(model: cellViewModel) }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FavoriteHeaderReusableView.identifier, for: indexPath) as? FavoriteHeaderReusableView else { return UICollectionReusableView() }
        let sectionModel = items[indexPath.section]
        header.setup(model: sectionModel)
        return header
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return items[section].headerSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return constants.cellPadding
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: constants.cellWidth, height: constants.cellHeight)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.section].cells[indexPath.item]
        viewModel?.didSelect(item: item)
    }
}
