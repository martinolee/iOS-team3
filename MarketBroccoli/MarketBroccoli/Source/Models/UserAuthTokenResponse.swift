//
//  UserAuthTokenResponse.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

struct UserAuthTokenResponse: Decodable {
  let token: String
  let user: LoginUser
  
  private enum CodingKeys: String, CodingKey {
    case token
    case user
  }
}

struct LoginUser: Decodable {
  let identification: Int
  let email: String
  let userName: String
  let address: Address
  let mobile: UserMobileCodeResponse
  let birthday: String?
  let gender: String
  let lastLogin: String
  
  private enum CodingKeys: String, CodingKey {
    case identification = "id"
    case email
    case userName = "username"
    case address
    case mobile
    case birthday = "birth_date"
    case gender
    case lastLogin = "last_login"
  }
}
