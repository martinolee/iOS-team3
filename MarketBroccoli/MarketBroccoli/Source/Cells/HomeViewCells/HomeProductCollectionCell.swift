//
//  HomeProductCollectionCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeProductCollectionCell: UICollectionViewCell {
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleToFill
    $0.image = UIImage(named: "cloud")
  }
  
  private let titleLabel = UILabel().then {
    $0.text = "구름이"
    $0.numberOfLines = 0
  }
  
  private let priceLabel = UILabel().then {
    $0.text = "비매품"
  }
  
  private let strikethroughPriceLabel = UILabel().then {
    $0.text = "비매품"
    $0.textColor = .gray
    $0.strikethrough()
  }
  
  private lazy var descriptionView = UIStackView().then {
    $0.addArrangedSubview(titleLabel)
    $0.addArrangedSubview(priceLabel)
    $0.addArrangedSubview(strikethroughPriceLabel)
    $0.spacing = 4
    $0.axis = .vertical
    $0.distribution = .fillEqually
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeProductCollectionCell {
  private func setupUI() {
    self.contentView.addSubviews([imageView, descriptionView])
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(80)
    }
    
    descriptionView.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
  }
}
