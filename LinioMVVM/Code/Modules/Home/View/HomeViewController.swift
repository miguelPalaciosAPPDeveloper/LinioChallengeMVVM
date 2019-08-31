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

    private typealias constants = HomeConstants

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        animateView()
    }

    // MARK: - Private functions.
    fileprivate func setupButton() {
        enterButton.alpha = 0.0
        enterButton.layer.shadowRadius = constants.radius
        enterButton.layer.cornerRadius = constants.radius
        enterButton.layer.shadowOpacity = constants.shadowOpacity
        enterButton.layer.shadowColor = constants.shadowColor.cgColor
        enterButton.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        enterButton.layer.masksToBounds = true
    }

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

