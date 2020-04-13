//
//  CategoryDetailViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/13.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController {
  var categoryDetailNavigationTitle = ""
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupNavigtion()
  }
  override func viewWillDisappear(_ animated: Bool) {
    self.setupBroccoliNavigationBar(title: "카테고리")
    self.addNavigationBarCartButton()
  }
  // MARK: - Setup Attribute
  
  private func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    [] .forEach {
      view.addSubview($0)
    }
  }
  private func setupNavigtion() {
    self.addSubNavigationBarCartButton()
    self.setupSubNavigationBar(title: categoryDetailNavigationTitle)
  }
}
