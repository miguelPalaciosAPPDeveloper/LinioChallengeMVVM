//
//  ProductDetailViewController.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 9/1/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, InstantiableViewController, AnimationLoadable {
    static var storyboardFileName: String = "ProductDetail"

    // MARK: - IBOutlets.
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productQuantityLabel: UILabel!

    @IBOutlet weak var imageProductView: UIView!
    @IBOutlet weak var productInfoView: UIView!
    @IBOutlet weak var badgesStackView: UIStackView!

    // MARK: - IBOutlets badges.
    @IBOutlet weak var linioPlusView: UIView!
    @IBOutlet weak var linioPlus48View: UIView!
    @IBOutlet weak var refurbishedView: UIView!
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var airplaneView: UIView!
    @IBOutlet weak var freeShippingView: UIView!


    var viewModel: ProductDetailViewModelProtocol?
    var ProductPriceModel: ProductPriceModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView(isHidde: true)
        guard let viewModel = self.viewModel else { return }
        self.bind(to: viewModel)
        self.startAnimation(animation: LinioAnimations.loader) { [weak self] in
            self?.viewModel?.didLoad()
        }
    }

    // MARK: - IBActions.
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func minusProductAction(_ sender: UIButton) {
        self.viewModel?.changeProductQuantity(action: .minusProduct)
    }

    @IBAction func plusProductAction(_ sender: UIButton) {
        self.viewModel?.changeProductQuantity(action: .plusProduct)
    }

    // MARK: - Private functions.

    fileprivate func setupView(isHidde: Bool) {
        imageProductView.isHidden = isHidde
        productInfoView.isHidden = isHidde
        badgesStackView.isHidden = isHidde
    }

    /**
     Add observes to viewModel.
     **/
    fileprivate func bind(to viewModel: ProductDetailViewModelProtocol) {
        viewModel.productImage.observe(on: self) { [weak self] (image) in
            self?.productImageView.image = image
        }

        viewModel.productName.observe(on: self) { [weak self] (name) in
            self?.productNameLabel.text = name
        }

        viewModel.productBadgeStatus.observe(on: self) { [weak self] (model) in
            self?.linioPlusView.isHidden = model.hiddenLinioPlus
            self?.linioPlus48View.isHidden = model.hiddenLinioPlus48
            self?.refurbishedView.isHidden = model.hiddenRefurbished
            self?.newView.isHidden = model.hiddenNew
            self?.airplaneView.isHidden = model.hiddenAirPlane
            self?.freeShippingView.isHidden = model.hiddenFreeShipping
        }

        viewModel.productPriceModel.observe(on: self) { [weak self] (model) in
            self?.productPriceLabel.text = model.totalPrice
            self?.productQuantityLabel.text = String(model.quantity)
        }

        viewModel.route.observe(on: self) { [weak self] (route) in
            self?.handler(route)
        }
    }

    fileprivate func handler(_ route: ProductDetailViewModelRoute) {
        guard route == .closeLoader else { return }
        self.stopAnimation {
            DispatchQueue.main.async {
                self.setupView(isHidde: false)
            }
        }
    }
}
