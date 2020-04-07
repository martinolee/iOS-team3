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

struct User: Encodable {
  let userName: String
  let email: String
  let name: String
  let password: String
  let address: Address
  let mobile: String
  let agreed: Bool
  
  private enum CodingKeys: String, CodingKey {
    case userName = "username"
    case email = "admin@example.com"
    case name = "name"
    case password = "password"
    case mobile = "mobile"
    case address = "address"
    case agreed = "agreed"
  }
  
  struct Address: Encodable {
    let jibunAddress: String
    let roadAddress: String
    let zipCode: String
    
    private enum AddressKeys: String, CodingKey {
      case jibunAddress = "address_name"
      case roadAddress = "road_address"
      case zipCoode = "zip_code"
    }
  }
}

struct UserForm: Decodable {
  let identification: String
  let email: String
  let username: String
  let mobile: Mobile
  let address: Address
  let birthDate: String
  let gender: String
  let lastLogin: String
  
  private enum CodingKeys: String, CodingKey {
    case identification = "9"
    case email = "test2@example.com"
    case username = "username"
    case mobile = "mobile"
    case address = "address"
    case birthDate = "birth_date"
    case gender = "gender"
    case lastLogin = "last_login"
  }
  
  struct Mobile: Decodable {
    let number: String
    let isAuthenticated: Bool
    
    private enum MobileKeys: String, CodingKey {
      case number = "number"
      case isAuthenticated = "is_authenticated"
    }
  }
   
  struct Address: Decodable {
    let addressName: String
    let roadAddress: String
    let zipCode: String
    
    private enum AddressKeys: String, CodingKey {
      case addressName = "address_name"
      case roadAddress = "road_address"
      case zipCoode = "zip_code"
    }
  }
}
