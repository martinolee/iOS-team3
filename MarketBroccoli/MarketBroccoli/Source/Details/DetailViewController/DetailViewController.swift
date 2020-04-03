//
//  DetailViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/02.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  private let scrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
  }
  private let stackView = CategoryStackView(categories: Categories.DetailCategory, distribution: .fillProportionally)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    print("init")
    self.view.backgroundColor = .white
  }
}

extension DetailViewController {
  private func setupUI() {
    let safeArea = view.safeAreaLayoutGuide
    self.view.addSubviews([stackView, scrollView])
    stackView.snp.makeConstraints {
      $0.top.equalTo(safeArea.snp.top)
      $0.leading.trailing.equalTo(safeArea)
    }
  }
}
