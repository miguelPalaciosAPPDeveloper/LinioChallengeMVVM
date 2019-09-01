//
//  AnimationLoader.swift
//  LinioMVVM
//
//  Created by Miguel Palacios on 25/05/18.
//  Copyright © 2018 MadApplications. All rights reserved.
//

import UIKit
import Lottie

/**
 Class to create animation loader with lottie.
 **/
internal class AnimationLoader: NSObject {
    // MARK: Variables.
    private var animationView: AnimationView?
    private var viewController: UIViewController = UIViewController()
    private var contentView = UIView()

    // MARK: Constants.
    private let screen = UIScreen.main.bounds
    private let defaultDivisor: CGFloat = 2.0
    private let maximunAlpha: CGFloat = 0.55
    private let minimunAlpha: CGFloat = 0.0
    private let timeInterval: TimeInterval = 0.4

    static var shared = AnimationLoader()

    private override init() {}

    /**
     Setup views.
     - Parameter animation: object that implement Animations protocol.
     **/
    fileprivate func setupLoader(animation: Animations) {
        let defaultProduct: CGFloat = screen.height * 0.5

        self.contentView.alpha = minimunAlpha
        animationView = AnimationView(animation: animation)
        animationView?.loopMode = .loop
        animationView?.contentMode = .scaleAspectFill
        self.contentView.backgroundColor = .black

        animationView?.frame = CGRect(x: (screen.width - defaultProduct) / defaultDivisor,
                                     y: (screen.height - defaultProduct) / defaultDivisor,
                                     width: defaultProduct,
                                     height: defaultProduct)
        self.contentView.addSubview(animationView ?? UIView())
    }

    /**
     Start loader animation.
     - Parameter viewController: current viewController to start animation.
     - Parameter animation: object that implement Animations protocol.
     - Parameter completion: closure to indicate the final sentence.
     **/
    internal func startAnimation(to viewController: UIViewController, animation: Animations, completion: (() -> Void)?) {
        self.viewController = viewController
        self.contentView.frame = viewController.view.frame

        self.setupLoader(animation: animation)

        UIView.animate(withDuration: timeInterval) {
            self.contentView.alpha = self.maximunAlpha
        }

        self.viewController.view.addSubview(self.contentView)
        animationView?.play()
        completion?()
    }

    /**
     Stop loader animation.
     - Parameter completion: closure to indicate the final sentence.
     **/
    internal func stopAnimation(_ completion: (() -> Void)?) {
        UIView.animate(withDuration: timeInterval, animations: {
            self.contentView.alpha = self.minimunAlpha
        }, completion: { _ in
            self.animationView?.stop()
            self.contentView.removeFromSuperview()

            completion?()
        })
    }
}
