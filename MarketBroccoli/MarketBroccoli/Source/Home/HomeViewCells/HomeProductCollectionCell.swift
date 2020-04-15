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
    $0.text = ""
    $0.numberOfLines = 2
    $0.font = .systemFont(ofSize: 14)
  }
  
  private let priceLabel = UILabel().then {
    $0.text = ""
    $0.font = .systemFont(ofSize: 14, weight: .bold)
  }
  
  private let strikethroughPriceLabel = UILabel().then {
    $0.text = ""
    $0.textColor = .kurlyGray1
    $0.font = .systemFont(ofSize: 12)
  }
  
  private lazy var descriptionView = UIStackView().then {
    $0.addArrangedSubview(titleLabel)
    $0.addArrangedSubview(priceLabel)
    $0.addArrangedSubview(strikethroughPriceLabel)
    $0.axis = .vertical
//    $0.alignment = .top
    $0.distribution = .fillProportionally
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
  func configure(item: MainItem, width: CGFloat) {
    imageView.setImage(urlString: item.thumbImage)
    titleLabel.preferredMaxLayoutWidth = width
    titleLabel.text = item.name
    if item.discountRate > 0 {
      priceLabel.text = moneyFormatter(won: Float(item.price) * (1 - item.discountRate), hasUnit: true)
      strikethroughPriceLabel.text = moneyFormatter(won: item.price, hasUnit: true)
      strikethroughPriceLabel.strikethrough()
    } else {
      priceLabel.text = moneyFormatter(won: item.price, hasUnit: true)
      strikethroughPriceLabel.text = ""
    }
  }
}

extension HomeProductCollectionCell {
  private func setupUI() {
    self.contentView.addSubviews([imageView, descriptionView])
    
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.65)
    }
    
    descriptionView.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.35)
    }
  }
}
