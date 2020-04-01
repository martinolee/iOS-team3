//
//  SearchViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  // MARK: - Properties
  
  private lazy var searchView = SearchView().then {
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
  }
}

// MARK: - Action Handler

extension SearchViewController: SearchViewDelegate {
  func searchProductTextFieldEditingDidBegin(_ textField: UITextField, _ button: UIButton) {
    button.isEnabled = true
  }
  
  func searchProductTextFieldEditingChanged(_ textField: UITextField, _ text: String) {
    print("searchProductTextFieldEditingChanged")
  }
  
  func cancelSearchButtonTouched(_ button: UIButton, _ textField: UITextField) {
    print("cancelSearchButtonTouched")
    button.isEnabled = false
    textField.resignFirstResponder()
  }
}
