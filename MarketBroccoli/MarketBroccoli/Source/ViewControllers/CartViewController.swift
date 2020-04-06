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
  class Product {
    let name: String
    let imageURL: URL
    let originalPrice: Int?
    let currentPrice: Int
    
    init(name: String, imageURL: URL, originalPrice: Int?, currentPrice: Int) {
      self.name = name
      self.imageURL = imageURL
      self.originalPrice = originalPrice
      self.currentPrice = currentPrice
    }
  }
  
  class WishProduct {
    let product: Product
    var quantity: Int
    var isChecked: Bool
    
    init(product: Product, quantity: Int, isChecked: Bool) {
      self.product = product
      self.quantity = quantity
      self.isChecked = isChecked
    }
  }
  
  private var cartDummy: [[WishProduct]] = [
    [WishProduct(
      product: .init(name: "[선물세트][안국건강] 안심도 종합건강 4구세트",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1579595888120y0.jpg")!,
                     originalPrice: 190000, currentPrice: 95000),
      quantity: 3, isChecked: true)],
    [WishProduct(
      product: .init(name: "[베르나르도] 에퀴메 한식 1인 세트",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1584327333312y0.jpg")!,
                     originalPrice: nil, currentPrice: 390000),
      quantity: 2, isChecked: true)],
    [WishProduct(
      product: .init(name: "[JBL] PULSE4_블랙",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1584688100156y0.jpg")!,
                     originalPrice: nil, currentPrice: 269000),
      quantity: 1, isChecked: true)],
    [WishProduct(
      product: .init(name: "[김구원선생] 무농약 콩나물 200g",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/15675741261y0.jpg")!,
                     originalPrice: nil, currentPrice: 1300),
      quantity: 7, isChecked: true)],
    [WishProduct(
      product: .init(name: "[제주창해수산] 제주 옥돔 250~290g(냉동)",
                     imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1510708692930y0.jpg")!,
                     originalPrice: 19800, currentPrice: 17820),
      quantity: 5, isChecked: false)]
    ]
  
  private lazy var cartView = CartView().then {
    $0.dataSource = self
    $0.delegate = self
  }

  // MARK: - Life Cycle

  override func loadView() {
    view = cartView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupAttribute()
    setupLeftBarButtonItem()
    print("isCheckedAll:", isAllShoppingItemsChecked())
    setCorrectSelectAllProductCheckBoxStatus()
  }
  
  // MARK: Setup Attribute
  
  private func setupAttribute() {
    title = "장바구니"
    
    navigationController?.do({
      $0.navigationBar.barTintColor = .white
      $0.navigationBar.isTranslucent = false
      $0.navigationBar.barStyle = .black
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    })
  }
  
  @objc
  private func closeCart() {
    dismiss(animated: true)
  }
  
  private func setupLeftBarButtonItem() {
    let closeCartbutton = UIButton(type: .system).then {
      $0.tintColor = .black
      $0.setImage(UIImage(systemName: "xmark"), for: .normal)
      
      $0.addTarget(self, action: #selector(closeCart), for: .touchUpInside)
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeCartbutton)
  }
}

extension CartViewController: CartViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    cartDummy.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cartDummy[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let wishProduct = cartDummy[indexPath.section][indexPath.row]
    let product = cartDummy[indexPath.section][indexPath.row].product
    let image = ImageResource(downloadURL: product.imageURL)
    let cell = tableView.dequeue(CartProductTableViewCell.self).then {
      $0.deleagte = self
      $0.configure(
        name: product.name, productImage: image, originalPrice: product.originalPrice,
        currentPrice: product.currentPrice, quantity: wishProduct.quantity,
        isChecked: wishProduct.isChecked, shoppingItemIndexPath: indexPath
      )
    }
    
    return cell
  }
}

// MARK: - Action Handler

extension CartViewController: CartProductTableViewCellDelegate {  
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool, _ shoppingItemIndexPath: IndexPath) {
    cartDummy[shoppingItemIndexPath.section][shoppingItemIndexPath.row].isChecked = isChecked
    setCorrectSelectAllProductCheckBoxStatus()
  }
  
  func productRemoveButtonTouched(_ button: UIButton, _ shoppingItemIndexPath: IndexPath) {
    let removeShoppingItemAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: .alert).then {
      $0.addAction(UIAlertAction(title: "취소", style: .cancel))
      $0.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
        self.cartDummy[shoppingItemIndexPath.section].remove(at: shoppingItemIndexPath.row)
      }))
    }
    
    present(removeShoppingItemAlert, animated: true)
  }
  
  func productQuantityStepperValueChanged(_ value: Int, _ shoppingItemIndexPath: IndexPath) {
    cartDummy[shoppingItemIndexPath.section][shoppingItemIndexPath.row].quantity = value
    cartView.reloadCartTableViewData()
  }
}

extension CartViewController: CartViewDelegate {
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool) {
    for category in cartDummy {
      for product in category {
        product.isChecked = isChecked
        cartView.reloadCartTableViewData()
      }
    }
  }
  
  func removeSelectedProductButton(_ button: UIButton) {
    let message = "선택된 상품을 삭제하시겠습니까?"
    let removeShoppingItemAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert).then {
      $0.addAction(UIAlertAction(title: "취소", style: .cancel))
      $0.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
        for categoryIndex in self.cartDummy.indices.reversed() {
          for productIndex in self.cartDummy[categoryIndex].indices.reversed()
            where self.cartDummy[categoryIndex][productIndex].isChecked {
              self.cartDummy[categoryIndex].remove(at: productIndex)
              if self.cartDummy[categoryIndex].isEmpty { self.cartDummy.remove(at: categoryIndex) }
          }
        }
      }))
    }
    
    present(removeShoppingItemAlert, animated: true)
  }
}

// MARK: - Function

extension CartViewController {
  private func isAllShoppingItemsChecked() -> Bool {
    var isChecked: Bool?
    
    for category in cartDummy {
      for product in category {
        if isChecked != nil {
          if isChecked != product.isChecked {
            return false
          }
        } else {
          isChecked = product.isChecked
        }
      }
    }
    
    return true
  }
  
  private func setCorrectSelectAllProductCheckBoxStatus() {
    isAllShoppingItemsChecked() ?
      cartView.setSelectAllProductCheckBoxStatus(true) :
      cartView.setSelectAllProductCheckBoxStatus(false)
  }
}
