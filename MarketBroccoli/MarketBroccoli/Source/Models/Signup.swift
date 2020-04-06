//
//  Signup.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/01.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

enum Signup {
  case identification
  case password
  case passwordCheck
  case name
  case email
  case cellphone
  case cellphoneCheck
  case usingLaw
  case personalInfo
  case ageLimit
}

struct User: Codable {
  struct Address: Codable {
    let jibunAddress: String
    let roadAddress: String
    let zipCode: String
    
    private enum AddressKeys: String, CodingKey {
      case jibunAddress = "address_name"
      case roadAddress = "road_address"
      case zipCoode = "zip_code"
    }
  }
  
  let userName: String
  let email: String
  let password: String
  let mobile: String
  let address: Address
  
  private enum CodingKeys: String, CodingKey {
    case userName = "username"
    case email
    case password
    case mobile
    case address
  }
}
