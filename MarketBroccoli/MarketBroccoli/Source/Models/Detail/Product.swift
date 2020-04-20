//
//  Product.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/16.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

// MARK: - Product
struct ProductModel: Decodable {
  let id: Int
  let name, summary: String
  let price: Int
  let discountRate: Double
  let unit, amount, package, madeIn: String
  let productModelDescription: String
  let images: [Image]
  let options: [Option?]
  
  enum CodingKeys: String, CodingKey {
    case id, name, summary, price
    case discountRate = "discount_rate"
    case unit, amount, package
    case madeIn = "made_in"
    case productModelDescription = "description"
    case images, options
  }
}

// MARK: - Image
struct Image: Decodable {
  let name: String
  let image: String
}

// MARK: - Option
struct Option: Decodable {
  let pk: Int
  let name: String
  let price, product: Int
}
