//
//  UINavigationControllerExtension.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import UIKit

extension UINavigationController {
    /**
     Setup NavigationBar.
     - Parameter title: NavigationBar title.
     - Parameter leftIcon: bar button icon.
     - Parameter leftSelector: bar button selector.
     - Parameter target: target for event.
     **/
    func setup(title: String, leftIcon: LinioIcons = .none, leftSelector: Selector? = nil, target: Any? = nil) {
        setupNavigationBar(title: title)
        let leftItem = createLeftItem(leftIcon: leftIcon, leftSelector: leftSelector, target: target)
        let barButton = UIBarButtonItem(customView: leftItem)
        self.topViewController?.navigationItem.leftBarButtonItem = barButton

    }

    /**
     Change color and assign title.
     - Parameter title: NavigationBar title.
     **/
    fileprivate func setupNavigationBar(title: String) {
        let color = UIColor(red: 248.0 / 255.0,
                            green: 245.0 / 255.0,
                            blue: 245.0 / 255.0, alpha: 1.0)
        self.navigationBar.tintColor = color
        self.navigationBar.topItem?.title = title
        guard let font = UIFont(name: "Futura Medium", size: 22.0) else { return }
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }

    /**
     Create a left bar button
     - Parameter leftIcon: bar button icon.
     - Parameter leftSelector: bar button selector.
     - Parameter target: target for event.
     **/
    fileprivate func createLeftItem(leftIcon: LinioIcons, leftSelector: Selector?, target: Any?) -> UIView {
        let barButton = UIButton()
        var selector: Selector = isModal() ? #selector(dismissView) : #selector(popView)

        if let newSelector = leftSelector {
            selector = newSelector
        }

        let buttonTarget = target ?? self
        barButton.addTarget(buttonTarget, action: selector, for: .touchUpInside)
        barButton.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 30.0, height: 40.0))
        barButton.setImage(leftIcon.icon, for: .normal)
        let buttonView = UIView(frame: barButton.frame)
        buttonView.bounds = buttonView.bounds.offsetBy(dx: 0, dy: 5.0)
        buttonView.addSubview(barButton)
        return buttonView
    }

    @objc fileprivate func popView() {
        self.popViewController(animated: true)
    }

    @objc fileprivate func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    /**
     Verify if the viewController was presented like modal or push.
     - Returns: Bool value.
     **/
    fileprivate func isModal() -> Bool {
        if self.viewControllers.first != self.topViewController {
            return false
        } else if self.topViewController?.presentingViewController != nil ||
            self.presentingViewController?.presentedViewController == self {
            return true
        } else {
            return false
        }
    }
}
