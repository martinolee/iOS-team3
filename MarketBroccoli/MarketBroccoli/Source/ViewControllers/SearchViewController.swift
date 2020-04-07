//
//  SearchViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import Kingfisher
import UIKit

class SearchViewController: UIViewController {
  // MARK: - Properties
  
  class Product {
    let name: String
    let imageURL: URL
    let originalPrice: Int?
    let currentPrice: Int
    let additionalInfo: [String]
    
    init(
      name: String, imageURL: URL, originalPrice: Int?, currentPrice: Int, additionalInfo: [String]
    ) {
      self.name = name
      self.imageURL = imageURL
      self.originalPrice = originalPrice
      self.currentPrice = currentPrice
      self.additionalInfo = additionalInfo
    }
  }
  
  private var productDummy: [Product] = [
    Product(
      name: "[바다원] 추자도 돌미역(산모미역) 150g",
      imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1510708692930y0.jpg")!,
      originalPrice: 8200,
      currentPrice: 7380,
      additionalInfo: ["Kurly Only", "한정수량"]
    ),
    Product(
      name: "[바다원] 추자도 돌미역(산모미역) 150g",
      imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1510708692930y0.jpg")!,
      originalPrice: nil,
      currentPrice: 7380,
      additionalInfo: ["Kurly Only"]
    ),
    Product(
      name: "[바다원] 추자도 돌미역(산모미역) 150g",
      imageURL: URL(string: "https://img-cf.kurly.com/shop/data/goods/1510708692930y0.jpg")!,
      originalPrice: nil,
      currentPrice: 7380,
      additionalInfo: []
    )
  ]
  
  private lazy var searchView = SearchView().then {
    $0.dataSource = self
    $0.delegate = self
  }
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addNavigationBarCartButton()
    self.setupBroccoliNavigationBar(title: "검색")
    
    for _ in 1...5 { productDummy += productDummy }
  }
}

extension SearchViewController: SearchViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    productDummy.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let product = productDummy[indexPath.row]
    let cell = collectionView.dequeue(ProductCollectionCell.self, indexPath: indexPath).then {
      $0.delegate = self
      $0.configure(
        productName: product.name,
        productImage: ImageResource(downloadURL: product.imageURL),
        originalPrice: product.originalPrice,
        currentPrice: product.currentPrice,
        additionalInfo: product.additionalInfo,
        productIndexPath: indexPath
      )
    }
    
    return cell
  }
}

// MARK: - Action Handler

extension SearchViewController: SearchViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
  
  func searchProductTextFieldEditingDidBegin(_ textField: UITextField, _ button: UIButton) {
    button.isEnabled = true
  }
  
  func searchProductTextFieldEditingChanged(_ textField: UITextField, _ text: String) {
    print("searchProductTextFieldEditingChanged")
  }
  
  func cancelSearchButtonTouched(_ button: UIButton, _ textField: UITextField) {
    textField.text = ""
    button.isEnabled = false
    textField.resignFirstResponder()
  }
}

extension SearchViewController: ProductCollectionCellDelegate {
}
