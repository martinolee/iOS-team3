//
//  CartViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import Alamofire
import Kingfisher
import UIKit

class CartViewController: UIViewController {
  // MARK: - Properties
  struct Product {
    let name: String
    let imageURL: URL
    let originalPrice: Int?
    let currentPrice: Int
  }
  
  struct WishProduct {
    let product: Product
    let quantity: Int
  }
  
  private var cartDummy: [WishProduct] = [
    WishProduct(
      product: .init(name: "[선물세트][안국건강] 안심도 종합건강 4구세트",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1579595888120y0.jpg")!,
                     originalPrice: 190000, currentPrice: 95000),
      quantity: 3),
    WishProduct(
      product: .init(name: "[베르나르도] 에퀴메 한식 1인 세트",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1584327333312y0.jpg")!,
                     originalPrice: nil, currentPrice: 390000),
      quantity: 2),
    WishProduct(
      product: .init(name: "[JBL] PULSE4_블랙",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1584688100156y0.jpg")!,
                     originalPrice: nil, currentPrice: 269000),
      quantity: 1),
    WishProduct(
      product: .init(name: "[김구원선생] 무농약 콩나물 200g",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/15675741261y0.jpg")!,
                     originalPrice: nil, currentPrice: 1300),
      quantity: 7),
    WishProduct(
      product: .init(name: "[제주창해수산] 제주 옥돔 250~290g(냉동)",
                     imageURL: URL(string: "https://www.naver.com")!,
                     originalPrice: 19800, currentPrice: 17820),
      quantity: 5)
  ]
  
  private lazy var cartView = CartView().then {
    $0.delegate = self
  }

  // MARK: - Life Cycle

  override func loadView() {
    view = cartView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension CartViewController: CartViewDelegate {  
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cartDummy.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let product = cartDummy[indexPath.row].product
    let quantity = cartDummy[indexPath.row].quantity
    let image = ImageResource(downloadURL: product.imageURL)
    let cell = tableView.dequeue(CartProductTableViewCell.self).then {
      $0.deleagte = self
      $0.configure(
        name: product.name, productImage: image, originalPrice: product.originalPrice,
        currentPrice: product.currentPrice, quantity: quantity
      )
    }
    
    return cell
  }
}

extension CartViewController: CartProductTableViewCellDelegate {
  func selectingOptionButtonTouched(_ button: UIButton) {
    print("selectingOptionButtonTouched")
  }
  
  func productRemoveButtonTouched(_ button: UIButton) {
     print("productRemoveButtonTouched")
  }
  
  func subtractionButtonTouched(_ button: UIButton) {
    print("subtractionButtonTouched")
  }
  
  func additionButtonTouched(_ button: UIButton) {
    print("additionButtonTouched")
  }
}
