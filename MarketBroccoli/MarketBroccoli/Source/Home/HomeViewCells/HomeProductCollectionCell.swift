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
  }
  
  private lazy var titleLabel = UILabel().then {
    $0.text = "구름이"
    $0.preferredMaxLayoutWidth = 165
    $0.numberOfLines = 2
  }
  
  private let priceLabel = UILabel().then {
    $0.text = "비매품"
    $0.font = .systemFont(ofSize: 16, weight: .bold)
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
  func configure(item: MainItem) {
    imageView.setImage(urlString: item.thumbImage.image)
    titleLabel.text = item.name
    priceLabel.text = item.price.description
  }
}

extension HomeProductCollectionCell {
  private func setupUI() {
    self.contentView.addSubviews([imageView, descriptionView])
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.7)
    }
    
    descriptionView.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.3)
    }
  }
}
