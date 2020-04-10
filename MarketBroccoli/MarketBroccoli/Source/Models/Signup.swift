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
  case notPersonalInfo
  case sms
  case emailButton
  case ageLimit
}

struct User: Encodable {
  let userName: String
  let email: String
  let name: String
  let password: String
  let address: Address
  let mobile: String
  
  private enum CodingKeys: String, CodingKey {
    case userName = "username"
    case email
    case name
    case password
    case mobile
    case address
  }
}

struct Address: Encodable {
  let jibunAddress: String
  let roadAddress: String
  let zipCode: String
  
  private enum CodingKeys: String, CodingKey {
    case jibunAddress = "address_name"
    case roadAddress = "road_address"
    case zipCode = "zip_code"
  }
}
