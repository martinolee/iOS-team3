//
//  ProductDetailWithOption.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct ProductDetailWithOption: Codable {
  let optionID: Int
  let name: String
  let price: Int
  let product: Product
  
  private enum CodingKeys: String, CodingKey {
    case optionID = "pk"
    case name, price, product
  }
  
  struct Product: Codable {
    let productID: Int
    let name: String
    let price: Int
    let discountRate: Double
    let imageURL: String
    
    private enum CodingKeys: String, CodingKey {
      case productID = "pk"
      case name, price
      case discountRate = "discount_rate"
      case imageURL = "image"
    }
  }
}
