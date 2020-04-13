//
//  MainViewModel.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct MainModel: Decodable {
  let md: [[MainItem]]
  let recommendation, discount, new, best: [MainItem]
}

// MARK: - Best
struct MainItem: Decodable {
  let id: Int
  let thumbImage: String
  let name: String
  let price: Int
  let discountRate: Float
  let summary: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case thumbImage = "thumb_image"
    case name, price
    case discountRate = "discount_rate"
    case summary
  }
}
