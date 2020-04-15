//
//  Cart.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

typealias Cart = [CartElement]

struct CartElement: Codable {
    let id: Int
    let product: Option
    let option: Option?
    let quantity: Int
}

struct Option: Codable {
    let pk: Int
    let name: String
    let price, product: Int?
    let discountRate: Double?

    enum CodingKeys: String, CodingKey {
        case pk, name, price, product
        case discountRate = "discount_rate"
    }
}
