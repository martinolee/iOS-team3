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
  
  func fetchCart(completionHandler: @escaping (Result<Cart, Error>) -> Void) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else {
      let cart = fetchLocalCart()
      completionHandler(.success(cart))
      
      return
    }
    
    AF.request(
      RequestCart.cart.endPoint,
      method: .get,
      headers: ["Authorization": "Token \(token)"]
    )
      .validate()
      .responseDecodable(of: BackendCart.self) { response in
        switch response.result {
        case .success(let backendCart):
          let cart = convertCart(from: backendCart)
          completionHandler(.success(cart))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func fetchCartCount(completionHandler: @escaping (Result<Int, Error>) -> Void) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else {
      let cartCount = fetchLocalCartCount()
      completionHandler(.success(cartCount))
      
      return
    }
    
    AF.request(
      RequestCart.cartCount.endPoint,
      method: .get,
      headers: ["Authorization": "Token \(token)"]
    )
      .validate()
      .responseDecodable(of: Int.self) { response in
        switch response.result {
        case .success(let cartCount):
          completionHandler(.success(cartCount))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func addProductIntoCart(_ product: UpdatedProduct,
                          completionHandler: @escaping (Result<BackendCartElement, Error>) -> Void) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else { return }
    
    AF.request(
      RequestCart.cart.endPoint,
      method: .post,
      parameters: product,
      encoder: JSONParameterEncoder.default,
      headers: [
        "Content-Type": "application/json",
        "Authorization": "Token \(token)"
      ]
    )
      .validate()
      .responseDecodable(of: BackendCartElement.self) { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func updateProductQuntity(
    id: Int, product: UpdatedProduct,
    completionHandler: @escaping (Result<BackendCartElement, Error>) -> Void
  ) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else { return }
    
    AF.request(
      RequestCart.updateProduct(id).endPoint,
      method: .patch,
      parameters: product,
      encoder: JSONParameterEncoder.default,
      headers: [
        "Content-Type": "application/json",
        "Authorization": "Token \(token)"
      ]
    )
      .validate()
      .responseDecodable(of: BackendCartElement.self) { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func removeProduct(id: Int, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else { return }
    
    AF.request(
      RequestCart.removeProduct(id).endPoint,
      method: .delete,
      headers: ["Authorization": "Token \(token)"]
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
}

extension CartManager {
  private func fetchLocalCart() -> Cart {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      let cart = try? JSONDecoder().decode(Cart.self, from: cartData)
    else {
      let cart = Cart()
      
      if let encodedCart = try? JSONEncoder().encode(cart) {
        UserDefaultManager.shared.set(encodedCart, for: .cart)
      }
      
      return cart
    }
    
    return cart
  }
  
  private func fetchLocalCartCount() -> Int {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      let cart = try? JSONDecoder().decode(Cart.self, from: cartData)
    else {
      let cart = Cart()
      
      if let encodedCart = try? JSONEncoder().encode(cart) {
        UserDefaultManager.shared.set(encodedCart, for: .cart)
      }
      
      return cart.count
    }
    
    return cart.count
  }
  
  private func addProductIntoLocalCart(wishProduct: UpdatedProduct) {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      var cart = try? JSONDecoder().decode([UpdatedProduct].self, from: cartData)
    else { return }
    
    for cartIndex in cart.indices {
      if let optionID = cart[cartIndex].option, let newOptionID = wishProduct.option {
        if cart[cartIndex].product == wishProduct.product && optionID == newOptionID {
          cart[cartIndex].quantity += wishProduct.quantity
        } else {
          cart.append(wishProduct)
        }
      } else {
        if cart[cartIndex].product == wishProduct.product {
          cart.append(wishProduct)
        }
      }
    }
    
    UserDefaultManager.shared.set(cart, for: .cart)
  }
  
  private func updateLocalProductQuntity(wishProduct: UpdatedProduct) {
    addProductIntoLocalCart(wishProduct: wishProduct)
  }
  
  private func removeLocalProduct(removedProductID: Int, removedOptionID: Int?) {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      var cart = try? JSONDecoder().decode([UpdatedProduct].self, from: cartData)
      else { return }
    
    for cartIndex in cart.indices {
      if let optionID = cart[cartIndex].option, let removedOptionID = removedOptionID {
        if cart[cartIndex].product == removedProductID && optionID == removedOptionID {
          cart.remove(at: cartIndex)
        }
      } else {
        if cart[cartIndex].product == removedProductID {
          cart.remove(at: cartIndex)
        }
      }
    }
    
    UserDefaultManager.shared.set(cart, for: .cart)
  }
}
