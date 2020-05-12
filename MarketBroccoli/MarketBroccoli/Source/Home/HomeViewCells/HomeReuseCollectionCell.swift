//
//  HomeReuseCollectionCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeReuseCollectionCell: UICollectionViewCell {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .green
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeReuseCollectionCell {
  private func setupUI() {
  }
}
