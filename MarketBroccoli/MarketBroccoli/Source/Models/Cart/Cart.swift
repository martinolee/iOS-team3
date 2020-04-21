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

struct ProductCategory {
  let id: Int
  let name: String?
  let discountRate: Double
  var wishProducts: [WishProduct]
}

struct WishProduct {
  let product: Product
  var quantity: Int
  var isChecked: Bool
}

struct Product {
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
  
  for backendProductCategory in backendCart {
    if let option = backendProductCategory.option {
      var hasSameCategory = false
      
      for index in cart.indices {
        if cart[index].id == option.product {
          cart[index].wishProducts.append(
            WishProduct(
              product: Product(
                cartID: backendProductCategory.id,
                id: option.pk,
                name: option.name,
                price: option.price,
                imageURL: backendProductCategory.product.imageURL
              ),
              quantity: backendProductCategory.quantity,
              isChecked: true
            )
          )
          
          hasSameCategory = true
          break
        }
      }
      
      if !hasSameCategory {
        cart.append(
          ProductCategory(
            id: backendProductCategory.product.pk,
            name: backendProductCategory.product.name,
            discountRate: backendProductCategory.product.discountRate,
            wishProducts: [
              WishProduct(
                product: Product(
                  cartID: backendProductCategory.id,
                  id: option.pk,
                  name: option.name,
                  price: option.price,
                  imageURL: backendProductCategory.product.imageURL
                ),
                quantity: backendProductCategory.quantity,
                isChecked: true
              )
          ])
        )
      }
    } else {
      if let price = backendProductCategory.product.price {
        cart.append(
          ProductCategory(
            id: backendProductCategory.product.pk,
            name: nil,
            discountRate: backendProductCategory.product.discountRate,
            wishProducts: [
              WishProduct(
                product: Product(
                  cartID: backendProductCategory.id,
                  id: backendProductCategory.product.pk,
                  name: backendProductCategory.product.name,
                  price: price,
                  imageURL: backendProductCategory.product.imageURL
                ),
                quantity: backendProductCategory.quantity,
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
    if let categoryName = productCategory.name {
      for wishProduct in productCategory.wishProducts {
        backendCart.append(
          BackendCartElement(
            id: wishProduct.product.cartID,
            product: BackendProduct(
              pk: productCategory.id,
              name: categoryName,
              discountRate: productCategory.discountRate,
              price: nil,
              imageURL: wishProduct.product.imageURL
            ),
            option: BackendOption(
              pk: wishProduct.product.id,
              name: wishProduct.product.name,
              price: wishProduct.product.price,
              product: productCategory.id
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
            pk: productCategory.id,
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
