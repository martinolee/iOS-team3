//
//  ProductList.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct ProductList {
  let id: Int?
  let name: String?
  let discountRate: Double
  var productOptions: [SelectableProduct]
}

struct SelectableProduct {
  let product: ProductOption
  var quantity: Int
}

struct ProductOption {
  let id: Int
  let name: String
  let price: Int
}

struct BEOptions: Decodable {
  let options: [Option]
  
  struct Option: Decodable {
    let id: Int
    let name: String
    let price, product: Int
    
    private enum CodingKeys: String, CodingKey {
      case id = "pk"
      case name, price, product
    }
  }
}
