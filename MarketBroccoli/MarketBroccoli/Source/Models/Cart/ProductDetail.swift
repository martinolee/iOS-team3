//
//  ProductDetail.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct ProductDetail: Codable {
  let productID: Int
  let name: String
  let price: Int
  let discountRate: Double
  let imageURL: String
  
  enum CodingKeys: String, CodingKey {
    case productID = "pk"
    case name, price
    case discountRate = "discount_rate"
    case imageURL = "image"
  }
}
