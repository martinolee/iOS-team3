//
//  CategoryDetailHeaderView.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDetailHeaderView: UIScrollView {
  static let identifier: String = "CategoryDetailHeaderView"
  
  private let title = UIButton().then {
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    $0.setTitleColor(UIColor.gray, for: .normal)
    //    $0.addTarget(self(), action: #selector(<#T##@objc method#>), for: .touchUpInside)
  }
  private let bottomLine = UIView().then {
    $0.backgroundColor = .red
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
//    self.contentSize = CGSize()
//    self.isScrollEnabled = true
    [title, bottomLine].forEach {
      self.addSubview($0)
    }
  }
  private func setupLayout() {
    title.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.bottom.equalTo(bottomLine.snp.top).offset(-10)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
    bottomLine.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(0.4)
    }
  }
  func title(name: String) {
    print(#function)
    print("Content Size before set title :", self.contentSize)
    title.setTitle(name, for: .normal)
    print("Content Size after set title :", self.contentSize)
  }
}
