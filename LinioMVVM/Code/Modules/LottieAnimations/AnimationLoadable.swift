//
//  AnimationLoadable.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 6/22/19.
//  Copyright © 2019 MadApplications. All rights reserved.
//

import Foundation
import UIKit
import Lottie

/**
 Protocol to create AnimationLoader on a UIViewController.
 **/
protocol AnimationLoadable {}

/**
 Extension to indicate that this protocol is for UIViewControllers.
 **/
extension AnimationLoadable where Self: UIViewController {

    /**
     Start loader animation.
     - Parameter animation: object that implement Animations protocol.
     - Parameter completion: closure to indicate the final sentence.
     **/
    func startAnimation(animation: Animations, completion: (() -> Void)?) {
        AnimationLoader.shared.startAnimation(to: self, animation: animation, completion: completion)
    }

    /**
     Stop loader animation.
     - Parameter completion: closure to indicate the final sentence.
     **/
    func stopAnimation(_ completion: (() -> Void)?) {
        AnimationLoader.shared.stopAnimation(completion)
    }
}
