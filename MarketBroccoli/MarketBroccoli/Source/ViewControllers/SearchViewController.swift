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
  
  private var isShowingPopularSearchWords = true
  
  private let popularSearchWords = ["사골곰탕", "마스크팩", "베트남 용과", "로트벡쉔", "한돈 등심", "자몽", "손질새우"]
  
  private var recentSearchWords = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"] {
    didSet {
      if recentSearchWords.count > 10 { recentSearchWords.removeLast() }
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
    searchWordTableViewWillFollowKeyboard()
    
    for _ in 1...5 { productDummy += productDummy }
  }
}

// MARK: - Data Source

extension SearchViewController: SearchViewDataSource {
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    isShowingPopularSearchWords ? "인기검색어" : "최근 검색어"
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    isShowingPopularSearchWords ? popularSearchWords.count : recentSearchWords.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let text = isShowingPopularSearchWords ? popularSearchWords[indexPath.row] : recentSearchWords[indexPath.row]
    let cell = isShowingPopularSearchWords ?
      tableView.dequeue(PopularSearchWordCell.self) : tableView.dequeue(RecentSearchWordCell.self)
    
    cell.do {
      $0.textLabel?.text = text
    }
    
    return cell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    viewForSupplementaryElementOfKind kind: String,
    at indexPath: IndexPath) -> UICollectionReusableView {
    collectionView.dequeue(ProductCollectionHeader.self, indexPath: indexPath).then {
      print($0)
    }
  }
  
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
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let text = isShowingPopularSearchWords ? popularSearchWords[indexPath.row] : recentSearchWords[indexPath.row]
    
    searchView.setSearchProductTextField(text: text)
    searchView.resignSearchProductTextFieldFirstResponder()
    searchView.hideSearchResultCollectionView(false)
    searchView.hideSearchWordTableView(true)
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  }
  
  func searchProductTextFieldEditingDidBegin(_ textField: UITextField, _ button: UIButton) {
    button.isEnabled = true
    
    isShowingPopularSearchWords = false
    searchView.reloadSearchWordTableViewData()
  }
  
  func searchProductTextFieldEditingChanged(_ textField: UITextField, _ text: String) {
    print("searchProductTextFieldEditingChanged")
  }
  
  func searchProductTextFieldSearchButtonTouched(_ textField: UITextField, _ text: String) {
    textField.resignFirstResponder()
    recentSearchWords.insert(text, at: 0)
    searchView.reloadSearchWordTableViewData()
    searchView.hideSearchWordTableView(true)
    searchView.hideSearchResultCollectionView(false)
  }
  
  func cancelSearchButtonTouched(_ button: UIButton, _ textField: UITextField) {
    textField.text = ""
    button.isEnabled = false
    textField.resignFirstResponder()
    
    isShowingPopularSearchWords = true
    searchView.reloadSearchWordTableViewData()
    searchView.hideSearchWordTableView(false)
    searchView.hideSearchResultCollectionView(true)
  }
  
  private func searchWordTableViewWillFollowKeyboard() {
    _ = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardDidShowNotification,
      object: nil,
      queue: OperationQueue.main) { (noti) in
        if let frameValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let keyboardFrame = frameValue.cgRectValue
          
          self.searchView.updateSearchWordTableViewBottomConstraint(keyboardFrame.size.height)
          self.view.layoutIfNeeded()
        }
    }
    
    _ = NotificationCenter.default.addObserver(
      forName: UIResponder.keyboardWillHideNotification,
      object: nil,
      queue: OperationQueue.main) { _ in
        self.searchView.updateSearchWordTableViewBottomConstraint(0)
        self.view.layoutIfNeeded()
    }
  }
}

extension SearchViewController: ProductCollectionCellDelegate {
}
