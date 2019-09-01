//
//  LottieExtension.swift
//  LinioMVVM
//
//  Created by Miguel Palacios on 25/05/18.
//  Copyright © 2018 MadApplications. All rights reserved.
//

import Foundation

import UIKit
import Lottie

/**
 Animations protocol for create enum with lottie animations.
 **/
public protocol Animations {
    /**
     Variable name is the lottie animation name.
     **/
    var name: String { get }
}

extension AnimationView {
    convenience init(animation: Animations) {
        self.init(name: animation.name)
    }
}

enum LinioAnimations: Animations {
    case loader
}

extension LinioAnimations {
    var name: String {
        switch self {
        case .loader:
            return "linioLoader"
        }
    }
}
