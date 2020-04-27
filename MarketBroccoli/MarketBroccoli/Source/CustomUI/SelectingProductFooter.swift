//
//  SelectingProductFooter.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SelectingProductFooter: UITableViewHeaderFooterView {
  // MARK: - Properties
  
  private let containerView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let staticTotalPriceLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .bold)
    $0.text = "합계"
  }
  
  private let totalPriceLabel = UILabel().then {
    $0.textAlignment = .right
    $0.font = .systemFont(ofSize: 17, weight: .bold)
    
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  // MARK: - Life Cycle
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    addAllSubviews()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func addAllSubviews() {
    self.addSubview(containerView)
    
    containerView.addSubviews([
      staticTotalPriceLabel,
      totalPriceLabel
    ])
  }
  
  private func setupAutoLayout() {
    containerView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(8)
    }
    
    staticTotalPriceLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalToSuperview().inset(8)
    }
    
    totalPriceLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(staticTotalPriceLabel.snp.trailing)
      $0.trailing.equalToSuperview().inset(8)
    }
  }
  
  func configure(totalPrice: Int) {
    totalPriceLabel.text = moneyFormatter(won: totalPrice, hasUnit: true)
  }
}
