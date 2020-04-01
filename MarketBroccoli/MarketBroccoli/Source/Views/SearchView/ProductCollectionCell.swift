//
//  ProductCollectionCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/01.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell {
  // MARK: - Properties
  
  private let productImageView = UIImageView().then {
    
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAttribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .green
  }
  
  // MARK: - Action Handler
}
