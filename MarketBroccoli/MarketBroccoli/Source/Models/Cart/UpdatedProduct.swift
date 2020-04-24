//
//  UpdatedProduct.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UpdatedProduct: Codable {
  let product: Int
  let option: Int?
  var quantity: Int
  
  private enum CodingKeys: String, CodingKey {
    case product, option, quantity
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(product, forKey: .product)
    try container.encode(option, forKey: .option)
    try container.encode(quantity, forKey: .quantity)
  }
}
