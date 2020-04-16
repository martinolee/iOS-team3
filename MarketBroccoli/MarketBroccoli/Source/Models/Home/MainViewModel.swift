//
//  MainViewModel.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

// MARK: - Best
struct MainItem: Decodable {
  let id: Int
  let thumbImage: String
  let name: String
  let price: Int
  let discountRate: Double
  let summary: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case thumbImage = "thumb_image"
    case name, price
    case discountRate = "discount_rate"
    case summary
  }
}
typealias HomeImages = [String]
typealias MDItems = [[MainItem]]
typealias HomeItems = [MainItem]
