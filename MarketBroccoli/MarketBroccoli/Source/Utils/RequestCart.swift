//
//  RequestCart.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/22.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

enum RequestCart: RequestProtocol {
  case cart, cartCount, addProduct, updateProduct(Int), removeProduct(Int)
  
  var endPoint: String {
    switch self {
    case .cart:
      return baseUrl + "/kurly/cart/"
    case .cartCount:
      return baseUrl + "/kurly/cart/count/"
    case .addProduct:
      return baseUrl + "/kurly/cart/"
    case .updateProduct(let id):
      return baseUrl + "/kurly/cart/\(id)/"
    case .removeProduct(let id):
      return baseUrl + "/kurly/cart/\(id)/"
    }
  }
}
