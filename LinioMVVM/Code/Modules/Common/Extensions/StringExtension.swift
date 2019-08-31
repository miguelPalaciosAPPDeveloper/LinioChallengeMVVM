//
//  StringExtension.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

let linioLocalizables = "LinioChallengeLocalizables"

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: linioLocalizables, bundle: Bundle.main, value: "", comment: "")
    }
}
