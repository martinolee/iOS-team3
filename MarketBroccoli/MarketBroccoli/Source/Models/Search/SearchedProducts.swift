//
//  SearchedProducts.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/21.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

typealias SearchedProducts = [SearchedProduct]

struct SearchedProduct: Codable {
    let id: Int
    let imageURL: String
    let name: String
    let price: Int
    let discountRate: Double
    let summary: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "thumb_image"
        case name, price
        case discountRate = "discount_rate"
        case summary
    }
}
