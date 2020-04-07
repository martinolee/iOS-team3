//
//  ProductCollectionHeader.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ProductCollectionHeader: UICollectionReusableView {
  // MARK: - Properties
  
  private lazy var selectingDeliveryAreaButton = UIButton(type: .system).then {
    $0.setTitle("샛별지역상품", for: .normal)
  }
  
  private lazy var selectingOrderTypeButton = UIButton(type: .system).then {
    $0.setTitle("신상품순", for: .normal)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllView()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubviews([
      selectingDeliveryAreaButton,
      selectingOrderTypeButton
    ])
  }
  
  private func setupAutoLayout() {
    selectingDeliveryAreaButton.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
    }
    
    selectingOrderTypeButton.snp.makeConstraints {
      $0.top.bottom.trailing.equalToSuperview()
    }
  }
}
