//
//  CartFooterView.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/26.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol CartFooterViewDataSource: class {
}

class CartFooterView: UIView {
  // MARK: - Properties
  
  weak var dataSource: CartFooterViewDataSource?
  
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
    self.backgroundColor = .white
  }
}
