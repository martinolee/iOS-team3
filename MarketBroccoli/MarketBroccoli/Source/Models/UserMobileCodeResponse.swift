//
//  UserMobileCodeResponse.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/08.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UserMobileCodeResponse: Decodable {
  let number: String
  let isAuthenticated: Bool
  private enum CodingKeys: String, CodingKey {
    case number = "number"
    case isAuthenticated = "is_authenticated"
  }
}
