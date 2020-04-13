//
//  UserAuthToken.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UserAuthToken: Encodable {
  let userName: String
  let password: String
  
  private enum CodingKeys: String, CodingKey {
    case userName = "username"
    case password
  }
}








