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
  func cartOrAlarmButtonTouched(_ button: UIButton, _ productIndexPath: IndexPath)
}

class ProductCollectionCell: UICollectionViewCell {
  // MARK: - Properties
  
  weak var delegate: ProductCollectionCellDelegate?
  
  private var productIndexPath: IndexPath!
  
  private let eventMark = EventMark()
  
  private lazy var cartOrAlarmButton = UIButton(type: .system).then {
    $0.clipsToBounds = true
    $0.tintColor = .white
    $0.backgroundColor = UIColor.kurlyPurple1.withAlphaComponent(0.5)
    
    $0.addTarget(self, action: #selector(cartOrAlarmButtonTouched(_:)), for: .touchUpInside)
  }
  
  private let dimView = UILabel().then {
    $0.font = .systemFont(ofSize: 24, weight: .bold)
    $0.textAlignment = .center
    $0.textColor = .white
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    $0.text = "Coming Soon"
  }
  
  private let productImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.backgroundColor = .kurlyGray3
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
  
  var productId: Int?
  
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
  
  override func layoutSubviews() {
    makeCircle(cartOrAlarmButton)
  }

  // MARK: - Setup UI
  
  private func makeCircle(_ view: UIView) {
    view.layer.cornerRadius = ((view.bounds.width + view.bounds.height) / 2) / 2
  }
  
  private func setupAttribute() {
  }
  
  private func addAllView() {
    contentView.addSubviews([
      productImageView,
      eventMark,
      dimView,
      cartOrAlarmButton,
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
    
    eventMark.snp.makeConstraints {
      $0.top.leading.equalTo(productImageView)
      $0.width.equalTo(productImageView).dividedBy(4)
      $0.height.equalTo(eventMark.snp.width)
    }
    
    dimView.snp.makeConstraints {
      $0.edges.equalTo(productImageView)
    }
    
    cartOrAlarmButton.snp.makeConstraints {
      $0.bottom.trailing.equalTo(productImageView).inset(10)
      $0.width.equalTo(productImageView).dividedBy(4)
      $0.height.equalTo(cartOrAlarmButton.snp.width)
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
      $0.bottom.equalTo(productInfoView).inset(6)
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
  @objc
  private func cartOrAlarmButtonTouched(_ button: UIButton) {
    delegate?.cartOrAlarmButtonTouched(button, productIndexPath)
  }
}

// MARK: - Element Control

extension ProductCollectionCell {
  func configure(
    productId id: Int, productName: String, productImage: String,
    price: Int, discount: Double,
    additionalInfo: [String], isSoldOut: Bool,
    productIndexPath: IndexPath
  ) {
    productId = id
    if discount != 0 {
      eventMark.isHidden = false
      let eventMarkAttributeString = NSMutableAttributedString()
        .normal("SAVE\n", textColor: .white, fontSize: 12)
        .bold("\(Int(discount * 100))", fontSize: 16)
        .normal("%", textColor: .white, fontSize: 12)
      eventMark.textLabel.attributedText = eventMarkAttributeString
      
      let originalPrice = moneyFormatter(won: Int(Double(price) / (1 - discount)), hasUnit: true)
      let originalPriceAttributeString = NSMutableAttributedString()
        .strikethrough(originalPrice, textColor: .kurlyGray2)
      originalPriceLabel.attributedText = originalPriceAttributeString
      
      currentPriceLabel.snp.updateConstraints {
        $0.leading.equalTo(originalPriceLabel.snp.trailing).offset(4)
      }
    } else {
      eventMark.isHidden = true
      eventMark.textLabel.text = ""
      
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
    
    if isSoldOut {
      cartOrAlarmButton.setImage(UIImage(systemName: "bell"), for: .normal)
      cartOrAlarmButton.setImage(UIImage(systemName: "bell.fill"), for: .highlighted)
      dimView.isHidden = false
    } else {
      cartOrAlarmButton.setImage(UIImage(systemName: "cart"), for: .normal)
      cartOrAlarmButton.setImage(UIImage(systemName: "cart.fill"), for: .highlighted)
      dimView.isHidden = true
    }
    
    let currentPrice = moneyFormatter(won: price, hasUnit: true)
    
    productNameLabel.text = productName
    productImageView.setImage(urlString: productImage)
    currentPriceLabel.text = currentPrice
    self.productIndexPath = productIndexPath
  }
}
