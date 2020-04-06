//
//  CategoryScrollView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/31.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryScrollView: UIScrollView {
  weak var customDelegate: MDCategoryTouchProtocol?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.showsHorizontalScrollIndicator = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(categories: [String]) {
    self.init()
    setupUI(categories: categories)
  }
}

extension CategoryScrollView {
  @objc private func cellTouched(_ sender: UITapGestureRecognizer) {
    guard let delegate = customDelegate else { return }
    delegate.cellTouch(index: 9999 - (sender.view?.tag ?? 0))
  }
}

extension CategoryScrollView {
  private func setupUI(categories: [String]) {
    let labels = categories.map { name -> UILabel in
      let label = UILabel().then {
        $0.textColor = .black
        $0.text = name
        $0.isUserInteractionEnabled = true
      }
      return label
    }
    self.addSubviews(labels)
    
    for idx in 0..<labels.count {
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTouched(_:)))
      labels[idx].tag = 9999 - idx
      labels[idx].addGestureRecognizer(tapGesture)
      if idx == 0 {
        labels[idx].snp.makeConstraints {
          $0.top.leading.bottom.equalToSuperview()
        }
      } else if idx == labels.count - 1 {
        labels[idx].snp.makeConstraints {
          $0.top.bottom.trailing.equalToSuperview()
          $0.leading.equalTo(labels[idx - 1].snp.trailing)
        }
      } else {
        labels[idx].snp.makeConstraints {
          $0.top.bottom.equalToSuperview()
          $0.leading.equalTo(labels[idx - 1].snp.trailing).offset(10)
        }
      }
      labels[idx].snp.makeConstraints {
        $0.height.equalTo(self)
      }
    }
  }
}
