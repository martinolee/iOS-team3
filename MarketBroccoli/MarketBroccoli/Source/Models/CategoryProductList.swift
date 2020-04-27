//
//  CategoryProductList.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/21.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

typealias CategoryProudcutList = [CategoryProudcutListElement]

struct CategoryProudcutListElement: Decodable {
  let id: Int
  let image: String
  let name: String
  let price: Int
  let discount: Double
  let summary: String
}

extension CategoryProudcutListElement { //CodingKey 단수 써야 함
  private enum CodingKeys: String, CodingKey {
    case id, name, price, summary
    case image = "thumb_image"
    case discount = "discount_rate"
  }
}
