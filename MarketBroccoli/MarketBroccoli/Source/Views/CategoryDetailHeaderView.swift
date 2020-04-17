//
//  CategoryDetailHeaderView.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDetailHeaderView: UIView {
  static let identifier: String = "CategoryDetailHeaderView"
  
  private let title = UILabel().then {
    $0.text = "나와라 얍"
    $0.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    $0.textColor = .black
  }
  private let bottomLine = UIView().then {
    $0.backgroundColor = .darkGray
  }
  
  override init(frame: CGRect) {
      super.init(frame: frame)
      setupUI()
      setupLayout()
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
      self.backgroundColor = .white
      [title, bottomLine].forEach {
        self.addSubview($0)
      }
    }
    private func setupLayout() {
      title.snp.makeConstraints {
        $0.leading.equalToSuperview().offset(16)
        $0.centerY.equalToSuperview()
      }
      bottomLine.snp.makeConstraints {
        $0.leading.trailing.bottom.equalToSuperview()
        $0.height.equalTo(1)
      }
    }
  }
