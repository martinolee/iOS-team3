//
//  ProductCollectionCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/01.
//  Copyright © 2020 Team3. All rights reserved.
//

import Kingfisher
import UIKit

protocol ProductCollectionCellDelegate: class {
}

class ProductCollectionCell: UICollectionViewCell {
  // MARK: - Properties
  
  weak var delegate: ProductCollectionCellDelegate?
  
  private var productIndexPath: IndexPath!
  
  private let productImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .brown
  }
  
  private let productInfoView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private let productNameLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 15)
    $0.textAlignment = .left
    $0.numberOfLines = 2
    
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .vertical)
  }
  
  private let originalPriceLabel = UILabel().then {
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 13)
    $0.textAlignment = .left
  }
  
  private let currentPriceLabel = UILabel().then {
    $0.textAlignment = .left
    $0.font = .systemFont(ofSize: 15, weight: .medium)
      
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAttribute()
    addAllView()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .green
  }
  
  private func addAllView() {
    contentView.addSubviews([
      productImageView,
      productInfoView
    ])
    
    productInfoView.addSubviews([
      productNameLabel,
      currentPriceLabel
    ])
  }
  
  private func setupAutoLayout() {
    productImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalToSuperview().dividedBy(1.4)
    }
    
    productInfoView.snp.makeConstraints {
      $0.top.equalTo(productImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
    
    productNameLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(8)
    }
    
    currentPriceLabel.snp.makeConstraints {
      $0.top.equalTo(productNameLabel.snp.bottom).offset(6)
      $0.leading.trailing.equalTo(productNameLabel)
    }
  }
}

// MARK: - Action Handler

extension ProductCollectionCell {
}

// MARK: - Element Control

extension ProductCollectionCell {
  func configure(
    productName: String, productImage: ImageResource,
    originalPrice: Int?, currentPrice: Int, productIndexPath: IndexPath
  ) {
    if let originalPrice = originalPrice {
      let originalPrice = moneyFormatter(won: originalPrice, hasUnit: true)
      let attributeString = NSMutableAttributedString(string: originalPrice)
      attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1,
                                   range: NSRange(location: 0, length: attributeString.length))
      originalPriceLabel.attributedText = attributeString
      
      productInfoView.addSubview(originalPriceLabel)
      originalPriceLabel.snp.makeConstraints {
        $0.leading.equalTo(productNameLabel)
        $0.bottom.equalTo(currentPriceLabel)
      }
      
      currentPriceLabel.snp.remakeConstraints {
        $0.top.equalTo(productNameLabel.snp.bottom).offset(4)
        $0.leading.equalTo(originalPriceLabel.snp.trailing).offset(4)
      }
    }
    
    let currentPrice = moneyFormatter(won: currentPrice, hasUnit: true)
    
    productNameLabel.text = productName
    productImageView.kf.setImage(with: productImage)
    currentPriceLabel.text = currentPrice
    self.productIndexPath = productIndexPath
  }
}
