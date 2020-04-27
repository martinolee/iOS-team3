//
//  Cart.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

typealias Cart = [ProductCategory]

extension Cart {
  var size: Int {
    var count = 0
    
    for productCategory in self {
      count += productCategory.wishProducts.count
    }
    
    return count
  }
}

struct ProductCategory: Codable {
  let id: Int?
  let name: String?
  let discountRate: Double
  var wishProducts: [WishProduct]
}

struct WishProduct: Codable {
  let product: Product
  var quantity: Int
  var isChecked: Bool
}

struct Product: Codable {
  let cartID: Int
  let id: Int
  let name: String
  let price: Int
  let imageURL: String
}

typealias BackendCart = [BackendCartElement]

struct BackendCartElement: Codable {
  let id: Int
  let product: BackendProduct
  let option: BackendOption?
  let quantity: Int
}

struct BackendProduct: Codable {
  let pk: Int
  let name: String
  let discountRate: Double
  let price: Int?
  let imageURL: String
  
  private enum CodingKeys: String, CodingKey {
    case pk, name, price
    case discountRate = "discount_rate"
    case imageURL = "image"
  }
}

struct BackendOption: Codable {
  let pk: Int
  let name: String
  let price, product: Int
}

func convertCart(from backendCart: BackendCart) -> Cart {
  var cart = Cart()
  
  for backendCartElement in backendCart {
    if let option = backendCartElement.option {
      var hasSameCategory = false
      
      for index in cart.indices {
        if cart[index].id == option.product {
          hasSameCategory = true
          
          cart[index].wishProducts.append(
            WishProduct(
              product: Product(
                cartID: backendCartElement.id,
                id: option.pk,
                name: option.name,
                price: option.price,
                imageURL: backendCartElement.product.imageURL
              ),
              quantity: backendCartElement.quantity,
              isChecked: true
            )
          )
          
          break
        }
      }
      
      if !hasSameCategory {
        cart.append(
          ProductCategory(
            id: backendCartElement.product.pk,
            name: backendCartElement.product.name,
            discountRate: backendCartElement.product.discountRate,
            wishProducts: [
              WishProduct(
                product: Product(
                  cartID: backendCartElement.id,
                  id: option.pk,
                  name: option.name,
                  price: option.price,
                  imageURL: backendCartElement.product.imageURL
                ),
                quantity: backendCartElement.quantity,
                isChecked: true
              )
          ])
        )
      }
    } else {
      if let price = backendCartElement.product.price {
        cart.append(
          ProductCategory(
            id: nil,
            name: nil,
            discountRate: backendCartElement.product.discountRate,
            wishProducts: [
              WishProduct(
                product: Product(
                  cartID: backendCartElement.id,
                  id: backendCartElement.product.pk,
                  name: backendCartElement.product.name,
                  price: price,
                  imageURL: backendCartElement.product.imageURL
                ),
                quantity: backendCartElement.quantity,
                isChecked: true
              )
          ])
        )
      }
    }
  }
  
  return cart
}

func convertBackendCart(from cart: Cart) -> BackendCart {
  var backendCart = BackendCart()
  
  for productCategory in cart {
    if let categoryName = productCategory.name, let productCategoryID = productCategory.id {
      for wishProduct in productCategory.wishProducts {
        backendCart.append(
          BackendCartElement(
            id: wishProduct.product.cartID,
            product: BackendProduct(
              pk: productCategoryID,
              name: categoryName,
              discountRate: productCategory.discountRate,
              price: nil,
              imageURL: wishProduct.product.imageURL
            ),
            option: BackendOption(
              pk: wishProduct.product.id,
              name: wishProduct.product.name,
              price: wishProduct.product.price,
              product: productCategoryID
            ),
            quantity: wishProduct.quantity
          )
        )
      }
    } else {
      backendCart.append(
         BackendCartElement(
          id: productCategory.wishProducts[0].product.cartID,
          product: BackendProduct(
            pk: productCategory.wishProducts[0].product.id,
            name: productCategory.wishProducts[0].product.name,
            discountRate: productCategory.discountRate,
            price: productCategory.wishProducts[0].product.price,
            imageURL: productCategory.wishProducts[0].product.imageURL
          ),
          option: nil,
          quantity: productCategory.wishProducts[0].quantity
        )
      )
    }
  }
  return backendCart
}
