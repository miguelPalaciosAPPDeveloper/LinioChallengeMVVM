//
//  LinioChallengeFavorites.swift
//  LinioMVVM
//
//  Created by Miguel De León Palacios on 8/31/19.
//  Copyright © 2019 MiguelPalacios. All rights reserved.
//

import Foundation

struct LinioFavoritesList: Codable {
    let createdAt: String
    let description: String
    let id: Int
    let name: String
    let visibility: String
    let owner: LinioOwner
    let products: [String: LinioProduct]
}

struct LinioOwner: Codable {
    let email: String
    let linioId: String
    let name: String
}

struct LinioProduct: Codable {
    let active: Bool
    let conditionType: String
    let freeShipping: Bool
    let id: Int
    let image: String
    let imported: Bool
    let linioPlusLevel: Int
    let name: String
    let slug: String
    let url: String
    let wishListPrice: Double
}
