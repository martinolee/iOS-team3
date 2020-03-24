//
//  HomeRootView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class HomeRootView: UIView {
  private let menuTextArray = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "이벤트"]
  private let scrollView = UIScrollView().then {
    $0.backgroundColor = .gray
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
  }
  
  private let stackViewBackground = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let stackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
    $0.distribution = .fillEqually
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeRootView {
  private func makeStackView() {
    menuTextArray.forEach { text in
      let label = UILabel().then {
        $0.text = text
        $0.font = .systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.textColor = .gray
      }
      stackView.addArrangedSubview(label)
    }
    stackView.insertSubview(stackViewBackground, at: 0)
  }
  
  private func setupUI() {
    let safeArea = self.safeAreaLayoutGuide
    makeStackView()
    [scrollView, stackView].forEach {
      self.addSubview($0)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(safeArea.snp.top)
      $0.leading.trailing.equalTo(self)
    }
    
    stackViewBackground.snp.makeConstraints {
      $0.top.leading.bottom.trailing.equalTo(stackView)
      $0.height.equalTo(40)
    }
    
    scrollView.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom)
      $0.leading.bottom.trailing.equalTo(safeArea)
    }
    
    var categoryArray: [UIView] = []
    for idx in 0..<menuTextArray.count {
      switch idx {
      case 0:
        categoryArray.append(RecommendationView())
      case 1...3:
        let product = NewProduct(frame: .zero, collectionViewLayout: CustomCollectionViewFlowLayout())
        product.dataSource = self
        product.register(cell: HomeReuseCollectionCell.self)
        categoryArray.append(product)
      case 4:
        categoryArray.append(RecommendationView())
      default:
        fatalError("out of range")
      }
    }
    
    for idx in 0..<categoryArray.count {
      scrollView.addSubview(categoryArray[idx])
      categoryArray[idx].snp.makeConstraints {
        if idx == 0 {
          $0.top.leading.bottom.equalToSuperview()
        } else if idx == categoryArray.count - 1 {
          $0.leading.equalTo(categoryArray[idx - 1].snp.trailing)
          $0.top.bottom.trailing.equalToSuperview()
        } else {
          $0.leading.equalTo(categoryArray[idx - 1].snp.trailing)
          $0.top.bottom.equalToSuperview()
        }
        $0.width.height.equalTo(self.scrollView)
      }
    }
  }
}

extension HomeRootView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeue(HomeReuseCollectionCell.self, indexPath: indexPath)
  }
}
