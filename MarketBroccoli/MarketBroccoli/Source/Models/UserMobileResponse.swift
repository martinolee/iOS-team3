//
//  UserMobileResponse.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/08.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UserMobileResponse: Decodable {
  let detail: String
  let status: Int
  let code: String
}
