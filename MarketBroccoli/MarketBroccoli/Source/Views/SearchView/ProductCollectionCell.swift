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
  
  private let firstAdditionalInfoLabel = UILabel().then {
    $0.layer.borderColor = UIColor.kurlyMainPurple.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .kurlyMainPurple
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 12)
  }
  
  private let secondAdditionalInfoLabel = UILabel().then {
    $0.layer.borderColor = UIColor.kurlyMainPurple.cgColor
    $0.layer.borderWidth = 1
    $0.textColor = .kurlyMainPurple
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 12)
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
  }
  
  private func addAllView() {
    contentView.addSubviews([
      productImageView,
      productInfoView
    ])
    
    productInfoView.addSubviews([
      productNameLabel,
      originalPriceLabel,
      currentPriceLabel,
      firstAdditionalInfoLabel,
      secondAdditionalInfoLabel
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
    
    originalPriceLabel.snp.makeConstraints {
      $0.leading.equalTo(productNameLabel)
      $0.bottom.equalTo(currentPriceLabel)
    }
    
    currentPriceLabel.snp.makeConstraints {
      $0.top.equalTo(productNameLabel.snp.bottom).offset(4)
      $0.leading.equalTo(originalPriceLabel.snp.trailing).offset(4)
    }
    
    firstAdditionalInfoLabel.snp.makeConstraints {
      $0.top.equalTo(originalPriceLabel.snp.bottom).offset(6)
      $0.leading.equalTo(productNameLabel)
    }
    
    secondAdditionalInfoLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(firstAdditionalInfoLabel)
      $0.leading.equalTo(firstAdditionalInfoLabel.snp.trailing).offset(4)
      $0.trailing.equalTo(productNameLabel)
      $0.width.equalTo(firstAdditionalInfoLabel)
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
    originalPrice: Int?, currentPrice: Int,
    additionalInfo: [String], productIndexPath: IndexPath
  ) {
    if let originalPrice = originalPrice {
      let originalPrice = moneyFormatter(won: originalPrice, hasUnit: true)
      let attributeString = NSMutableAttributedString(string: originalPrice)
      attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1,
                                   range: NSRange(location: 0, length: attributeString.length))
      originalPriceLabel.attributedText = attributeString
      
      currentPriceLabel.snp.updateConstraints {
        $0.leading.equalTo(originalPriceLabel.snp.trailing).offset(4)
      }
    } else {
      originalPriceLabel.text = ""
      
      currentPriceLabel.snp.updateConstraints {
        $0.leading.equalTo(originalPriceLabel.snp.trailing)
      }
    }
    
    if !additionalInfo.isEmpty {
      for infoIndex in additionalInfo.indices {
        switch infoIndex {
        case 0:
          firstAdditionalInfoLabel.isHidden = false
          secondAdditionalInfoLabel.isHidden = true
          
          firstAdditionalInfoLabel.text = additionalInfo[0]
          secondAdditionalInfoLabel.text = ""
        case 1:
          secondAdditionalInfoLabel.isHidden = false
          
          secondAdditionalInfoLabel.text = additionalInfo[1]
        default:
          print("extra info")
        }
      }
    } else {
      firstAdditionalInfoLabel.text = ""
      secondAdditionalInfoLabel.text = ""
      
      firstAdditionalInfoLabel.isHidden = true
      secondAdditionalInfoLabel.isHidden = true
    }
    
    let currentPrice = moneyFormatter(won: currentPrice, hasUnit: true)
    
    productNameLabel.text = productName
    productImageView.kf.setImage(with: productImage)
    currentPriceLabel.text = currentPrice
    self.productIndexPath = productIndexPath
  }
}
