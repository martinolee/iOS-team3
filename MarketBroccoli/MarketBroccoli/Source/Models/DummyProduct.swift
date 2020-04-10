//
//  DummyProduct.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

class DummyProduct {
  let name: String
  let imageURL: URL
  let price: Int
  let discount: Double
  let additionalInfo: [String]
  let isSoldOut: Bool
  
  init(
    name: String, imageURL: URL, price: Int, discount: Double, additionalInfo: [String], isSoldOut: Bool
  ) {
    self.name = name
    self.imageURL = imageURL
    self.price = price
    self.discount = discount
    self.additionalInfo = additionalInfo
    self.isSoldOut = isSoldOut
  }
}

var productDummy: [DummyProduct] = [
  DummyProduct(
    name: "[LOTS OF LOVE] 차돌듬뿍 묵은지볶음밥",
    imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1530775904381y0.jpg") ?? URL(fileURLWithPath: ""),
    price: 7_800,
    discount: 0,
    additionalInfo: [],
    isSoldOut: false
  ),
  DummyProduct(
    name: "[리터스포트] 4입 기획세트",
    imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/157948947221y0.jpg") ?? URL(fileURLWithPath: ""),
    price: 12_000,
    discount: 0.5,
    additionalInfo: ["Kurly Only"],
    isSoldOut: false
  ),
  DummyProduct(
    name: "[히스파수르] 골드 엑스트라 버진 피쿠알 2종 (2019-2020햇올리브)",
    imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1578294213131y0.jpg") ?? URL(fileURLWithPath: ""),
    price: 20_400,
    discount: 0.4,
    additionalInfo: ["Kurly Only", "한정수량"],
    isSoldOut: false
  ),
  DummyProduct(
    name: "[바켄] 바스크 치즈 케이크",
    imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1574752934698y0.jpg") ?? URL(fileURLWithPath: ""),
    price: 25_000,
    discount: 0,
    additionalInfo: ["Kurly Only"],
    isSoldOut: false
  )
]
