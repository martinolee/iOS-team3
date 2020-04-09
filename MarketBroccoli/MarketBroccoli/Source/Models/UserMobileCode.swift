//
//  UserMobileCode.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/08.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UserMobileCode: Encodable {
  let userMobile: String
  let token: String
  
  private enum CodingKeys: String, CodingKey {
    case userMobile = "number"
    case token
  }
}
