//
//  CartManager.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation
import Alamofire

class CartManager {
  static let shared = CartManager()
  
  private init() { }
  
  func addProductIntoCart(_ product: UpdatedProduct, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      "http://15.164.49.32/kurly/cart/",
      method: .post,
      parameters: product,
      encoder: JSONParameterEncoder.default,
      headers: ["Content-Type": "application/json"]
    )
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func patchProductQuntity(
    id: Int, product: UpdatedProduct,
    completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      "http://15.164.49.32/kurly/cart/\(id)/",
      method: .patch,
      parameters: product,
      encoder: JSONParameterEncoder.default,
      headers: ["Content-Type": "application/json"]
    )
      .authenticate(username: "admin", password: "admin123")
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func removeProduct(id: Int, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      "http://15.164.49.32/kurly/cart/\(id)/",
      method: .delete
    )
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func fetchCart(_ url: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(url)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
}
