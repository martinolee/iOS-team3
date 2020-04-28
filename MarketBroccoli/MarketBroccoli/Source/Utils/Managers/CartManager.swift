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
  
  func fetchProductDetail(id: Int, completionHandler: @escaping (Result<ProductDetail, Error>) -> Void) {
    AF.request(
      RequestCart.productDetail(id).endPoint,
      method: .get
    )
      .validate()
      .responseDecodable(of: ProductDetail.self) { response in
        switch response.result {
        case .success(let productDetail):
          completionHandler(.success(productDetail))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func fetchProductDetailWithOption(id: Int, option: Int,
                                    completionHandler: @escaping (Result<ProductDetailWithOption, Error>) -> Void) {
    AF.request(
      RequestCart.productDetailWithOption(id, option).endPoint,
      method: .get
    )
      .validate()
      .responseDecodable(of: ProductDetailWithOption.self) { response in
        switch response.result {
        case .success(let productDetail):
          completionHandler(.success(productDetail))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  func fetchCart(completionHandler: @escaping (Result<Cart, Error>) -> Void) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else {
      fetchLocalCart { cart in
        completionHandler(.success(cart))
      }
      
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
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else {
      addProductIntoLocalCart(wishProduct: product)
      
      return
    }
    
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
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else {
      updateLocalProductQuntity(wishProduct: product)
      
      return
    }
    
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
  
  func removeProduct(cartID: Int, productID: Int, optionID: Int?,
                     completionHandler: @escaping (Result<Data, Error>) -> Void) {
    guard let token = UserDefaultManager.shared.get(for: .token) as? String else {
      removeLocalProduct(productID: productID, optionID: optionID)
      
      return
    }
    
    AF.request(
      RequestCart.removeProduct(cartID).endPoint,
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

// MARK: - Local Cart

extension CartManager {
  private func fetchLocalCart(completionHandler: @escaping (Cart) -> Void) {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      let localCart = try? JSONDecoder().decode([UpdatedProduct].self, from: cartData),
      !localCart.isEmpty
    else {
      let cart = Cart()
      
      if let encodedCart = try? JSONEncoder().encode(cart) {
        UserDefaultManager.shared.set(encodedCart, for: .cart)
      }
      
      completionHandler(cart)
      return
    }
    
    var cart = Cart()
    
    for localCartIndex in localCart.indices {
      let localProduct = localCart[localCartIndex]
      
      if let option = localProduct.option {
        fetchProductDetailWithOption(id: localProduct.product, option: option) { result in
          switch result {
          case .success(let productDetail):
            var hasSameCategory = false
            
            for cartIndex in cart.indices where cart[cartIndex].id == productDetail.product.productID {
              cart[cartIndex].wishProducts.append(
                WishProduct(
                  product: Product(
                    cartID: localCartIndex,
                    id: productDetail.optionID,
                    name: productDetail.name,
                    price: productDetail.price,
                    imageURL: productDetail.product.imageURL
                  ),
                  quantity: localProduct.quantity,
                  isChecked: true
                )
              )
              hasSameCategory = true
              break
            }
            
            if !hasSameCategory {
              cart.append(
                ProductCategory(
                  id: productDetail.product.productID,
                  name: productDetail.product.name,
                  discountRate: productDetail.product.discountRate,
                  wishProducts: [
                    WishProduct(
                      product: Product(
                        cartID: localCartIndex,
                        id: productDetail.optionID,
                        name: productDetail.name,
                        price: productDetail.price,
                        imageURL: productDetail.product.imageURL
                      ),
                      quantity: localProduct.quantity,
                      isChecked: true
                    )
                  ]
                )
              )
            }
            
            if cart.size == localCart.count {
              completionHandler(cart)
            }
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
      } else {
        fetchProductDetail(id: localProduct.product) { result in
          switch result {
          case .success(let productDetail):
            cart.append(
              ProductCategory(
                id: nil,
                name: nil,
                discountRate: productDetail.discountRate,
                wishProducts: [
                  WishProduct(
                    product: Product(
                      cartID: localCartIndex,
                      id: productDetail.productID,
                      name: productDetail.name,
                      price: productDetail.price,
                      imageURL: productDetail.imageURL
                    ),
                    quantity: localProduct.quantity,
                    isChecked: true
                  )
                ]
              )
            )
            
            if cart.size == localCart.count {
              completionHandler(cart)
            }
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
      }
    }
  }
  
  private func fetchLocalCartCount() -> Int {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      let cart = try? JSONDecoder().decode([UpdatedProduct].self, from: cartData)
    else {
      let cart = [UpdatedProduct]()
      
      if let encodedCart = try? JSONEncoder().encode(cart) {
        UserDefaultManager.shared.set(encodedCart, for: .cart)
      }
      
      return cart.count
    }
    
    return cart.count
  }
  
  private func addProductIntoLocalCart(wishProduct: UpdatedProduct) {
    changeProduct(wishProduct: wishProduct, forUpdate: false)
  }
  
  private func updateLocalProductQuntity(wishProduct: UpdatedProduct) {
    changeProduct(wishProduct: wishProduct, forUpdate: true)
  }
  
  private func changeProduct(wishProduct: UpdatedProduct, forUpdate: Bool) {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      var cart = try? JSONDecoder().decode([UpdatedProduct].self, from: cartData)
    else { return }
    var hasSameProductInCart = false
    
    for cartIndex in cart.indices
      where cart[cartIndex].product == wishProduct.product && cart[cartIndex].option == wishProduct.option {
        hasSameProductInCart = true
        forUpdate
          ? (cart[cartIndex].quantity = wishProduct.quantity)
          : (cart[cartIndex].quantity += wishProduct.quantity)
        break
    }
    
    if !hasSameProductInCart {
      cart.append(wishProduct)
    }
    
    if let encodedCart = try? JSONEncoder().encode(cart) {
      UserDefaultManager.shared.set(encodedCart, for: .cart)
    }
  }
  
  private func removeLocalProduct(productID: Int, optionID: Int?) {
    guard
      let cartData = UserDefaultManager.shared.get(for: .cart) as? Data,
      var cart = try? JSONDecoder().decode([UpdatedProduct].self, from: cartData)
    else { return }
    
    for cartIndex in cart.indices
      where cart[cartIndex].product == productID && cart[cartIndex].option == optionID {
        cart.remove(at: cartIndex)
        break
    }
    
    if let encodedCart = try? JSONEncoder().encode(cart) {
      UserDefaultManager.shared.set(encodedCart, for: .cart)
    }
  }
}
