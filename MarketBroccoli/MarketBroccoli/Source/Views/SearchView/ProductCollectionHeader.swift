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
    $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    $0.setPreferredSymbolConfiguration(.init(pointSize: 14), forImageIn: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.tintColor = .black
    $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    $0.setTitle("샛별지역상품", for: .normal)
  }
  
  private lazy var selectingOrderTypeButton = UIButton(type: .system).then {
    $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    $0.setPreferredSymbolConfiguration(.init(pointSize: 14), forImageIn: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.tintColor = .black
    $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
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
      $0.top.bottom.equalToSuperview().inset(8)
      $0.leading.equalToSuperview().inset(22)
    }
    
    selectingOrderTypeButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(8)
      $0.trailing.equalToSuperview().inset(22)
    }
  }
}

extension ProductCollectionHeader {
  func configure(hideOrderTypeButton hide: Bool) {
    selectingOrderTypeButton.isHidden = hide
  }
}
