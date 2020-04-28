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
    $0.font = .systemFont(ofSize: 14, weight: .regular)
  }
  private let priceLabel = UILabel().then {
    $0.text = ""
    $0.font = .systemFont(ofSize: 14, weight: .semibold)
  }
  private let strikethroughPriceLabel = UILabel().then {
    $0.text = ""
    $0.textColor = .kurlyGray3
    $0.font = .systemFont(ofSize: 12)
  }
  private let eventMark = EventMark()
  
  private lazy var descriptionView = UIStackView().then {
    $0.addArrangedSubview(titleLabel)
    $0.addArrangedSubview(priceLabel)
    $0.addArrangedSubview(strikethroughPriceLabel)
    $0.axis = .vertical
    $0.distribution = .fillProportionally
  }
 
  var productId: Int?
  
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
    productId = item.id
    imageView.setImage(urlString: item.thumbImage)
    titleLabel.text = item.name
    if item.discountRate > 0 {
      priceLabel.text = moneyFormatter(won: item.price, hasUnit: true)
      strikethroughPriceLabel.text = moneyFormatter(won: Double(item.price) / (1 - item.discountRate), hasUnit: true)
      strikethroughPriceLabel.strikethrough()
      eventMarkResize(
        target: imageView,
        add: eventMark,
        discount: discountFormatter(discountRate: item.discountRate, hasUnit: false),
        width: width)
      eventMark.isHidden = false
    } else {
      priceLabel.text = moneyFormatter(won: item.price, hasUnit: true)
      strikethroughPriceLabel.text = ""
      eventMark.isHidden = true
    }
  }
  
  func eventMarkResize(target: UIImageView, add view: UIView, discount: String, width: CGFloat) {
    let eventMarkAttributeString = NSMutableAttributedString()
      .normal("SAVE\n", textColor: .white, fontSize: 10)
      .bold(discount, fontSize: 14)
      .normal("%", textColor: .white, fontSize: 10)
    eventMark.textLabel.attributedText = eventMarkAttributeString
    if (width / 4) < ((eventMark.textLabel.getWidth() ?? 0) + 4) {
      DispatchQueue.main.async {
        view.snp.remakeConstraints {
          $0.top.leading.equalTo(target)
          $0.width.equalTo(target).dividedBy(3)
          $0.height.equalTo(view.snp.width)
        }
      }
    }
  }
}

extension HomeProductCollectionCell {
  private func setupUI() {
    self.contentView.addSubviews([imageView, eventMark, titleLabel, priceLabel, strikethroughPriceLabel])
    imageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(0.6)
    }

    eventMark.snp.makeConstraints {
      $0.top.leading.equalTo(imageView)
      $0.width.equalTo(imageView).dividedBy(4)
      $0.height.equalTo(eventMark.snp.width)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
    
    priceLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview()
    }
    
    strikethroughPriceLabel.snp.makeConstraints {
      $0.top.equalTo(priceLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview()
    }
  }
}
