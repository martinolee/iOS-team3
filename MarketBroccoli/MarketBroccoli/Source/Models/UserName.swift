//
//  UserName.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/08.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UserName: Encodable {
  let userName: String
  
  private enum CodingKeys: String, CodingKey {
    case userName = "username"
  }
}
