//
//  HomeViewController.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/28/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets.
    @IBOutlet weak var linioLogoViewCenteConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterButton: UIButton!

    // MARK: - Properties.
    private typealias constants = LinioConstants
    private let localizables = LinioLocalizables()
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        animateView()
    }

    @IBAction func enterAction(_ sender: UIButton) {
        let navigationController = UINavigationController(rootViewController: FavoritesViewController.createInstance())
        self.present(navigationController, animated: true, completion: nil)
    }

    // MARK: - Private functions.

    /**
     Setup enterButton.
     - Add shadow and cornerRadius.
     **/
    fileprivate func setupButton() {
        enterButton.alpha = 0.0
        enterButton.layer.shadowRadius = constants.radius
        enterButton.layer.cornerRadius = constants.radius
        enterButton.layer.shadowOpacity = constants.shadowOpacity
        enterButton.layer.shadowColor = UIColor.lightGray.cgColor
        enterButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        enterButton.setTitle(localizables.homeButtonTitle, for: .normal)
        enterButton.layer.masksToBounds = false
    }

    /**
     Show an animation.
     - Linio logo animation.
     - EnterButton animation.
     **/
    fileprivate func animateView() {
        let screenHeight = UIScreen.main.bounds.height
        self.linioLogoViewCenteConstraint.constant = constants.defaultValue - (screenHeight / 2)
        UIView.animate(withDuration: 1.0, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1.0) {
                self.enterButton.alpha = 1.0
            }
        }
    }
}

