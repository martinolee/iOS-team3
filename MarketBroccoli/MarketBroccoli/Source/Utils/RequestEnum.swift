//
//  RequestEnum.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/16.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

enum RequestHome: RequestProtocol {
  case mainImages
  case md
  case recommendation
  case new
  case best
  case discount
  
  var endPoint: String {
    switch self {
    case .mainImages:
      return baseUrl + "/kurly/images/"
    case .md:
      return baseUrl + "/kurly/md/"
    case .recommendation:
      return baseUrl + "/kurly/recommend/"
    case .new:
      return baseUrl + "/kurly/new/"
    case .best:
      return baseUrl + "/kurly/best/"
    case .discount:
      return baseUrl + "/kurly/discount/"
    }
  }
}

enum RequestDetail: RequestProtocol {
  case detail
  
  var endPoint: String {
    switch self {
    case .detail:
      return baseUrl + "/kurly/product/"
    }
  }
}

enum RequestCategory: RequestProtocol {
  case initial
  case sub
  
  var endPoint: String {
    switch self {
    case .initial:
      return baseUrl + "/kurly/category/"
    case .sub:
      return baseUrl + "kurly/subcategory/"
    }
  }
}

enum RequestSignup: RequestProtocol {
  case duplicate
  case MTokenCreate
  case MTokenAuth
  case accounts
  case authToken
  
  var endPoint: String {
    switch self {
    case .duplicate:
      return baseUrl + "/accounts/duplicates/"
    case .MTokenCreate:
      return baseUrl + "/accounts/m-token-create/"
    case .MTokenAuth:
      return baseUrl + "/accounts/m-token-auth/"
    case .accounts:
      return baseUrl + "/accounts/"
    case .authToken:
      return baseUrl + "/accounts/auth-token/"
    }
  }
}
