//
//  MDCategoryCollectionCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class MDCategoryCollectionCell: UICollectionViewCell {
  let titleLabel = UILabel().then {
    $0.textColor = .gray
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MDCategoryCollectionCell {
  func configure(title: String) {
    titleLabel.text = title
  }
  private func setupUI() {
    self.contentView.addSubviews([titleLabel])
    
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
