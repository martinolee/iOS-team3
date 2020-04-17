//
//  ProductCategoryHeader.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/16.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ProductCategoryHeader: UITableViewHeaderFooterView {
  // MARK: - Property
  
  private let containerView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let productCategoryLabel = UILabel().then {
    $0.textAlignment = .left
    $0.textColor = .kurlyGray1
  }
  
  private let seperator = UIView().then {
    $0.backgroundColor = .kurlyGray3
  }
  
  private var categorySection: Int!
  
  // MARK: - Life Cycle
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    setupAttribute()
    addAllView()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    contentView.backgroundColor = .kurlyGray3
  }
  
  private func addAllView() {
    self.addSubview(containerView)
    
    containerView.addSubviews([
      productCategoryLabel,
      seperator
    ])
  }
  
  private func setupUI() {
    containerView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(8)
    }
    
    productCategoryLabel.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(8)
    }
    
    seperator.snp.makeConstraints {
      $0.leading.trailing.equalTo(productCategoryLabel)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(1)
    }
  }
  
  // MARK: - Element Control
  
  func configure(productCategoryName: String?) {
    if let productCategoryName = productCategoryName {
      productCategoryLabel.text = productCategoryName
    } else {
      productCategoryLabel.removeFromSuperview()
      seperator.removeFromSuperview()
      containerView.removeFromSuperview()
    }
  }
}
