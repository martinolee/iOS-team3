//
//  CartProductTableViewCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import Kingfisher
import Then
import UIKit

protocol CartProductTableViewCellDelegate: class {
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool, _ shoppingItemIndexPath: IndexPath)
  
  func productRemoveButtonTouched(_ button: UIButton, _ shoppingItemIndexPath: IndexPath)
  
  func productQuantityStepperValueChanged(_ value: Int, _ shoppingItemIndexPath: IndexPath)
}

class CartProductTableViewCell: UITableViewCell {
  // MARK: - Properties
  
  weak var deleagte: CartProductTableViewCellDelegate?
  
  private var shoppingItemIndexPath: IndexPath!
  
  private let topSeperator = UIView().then {
    $0.backgroundColor = .kurlyGray3
  }
  
  private let containerView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private lazy var checkBox = CheckBox(type: .system).then {
    $0.delegate = self
  }
  
  private lazy var nameLabel = UILabel().then {
    $0.textAlignment = .left
    $0.numberOfLines = 0
  }
  
  private lazy var productRemoveButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .black
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    
    $0.addTarget(self, action: #selector(productRemoveButtonTouched(_:)), for: .touchUpInside)
  }
  
  private let productImageView = UIImageView().then {
    $0.contentMode = .scaleToFill
  }
  
  private let originalPriceLabel = UILabel().then {
    $0.textAlignment = .left
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 15)
  }
  
  private let currentPriceLabel = UILabel().then {
    $0.textAlignment = .left
  }
  
  private lazy var productQuantityStepper = ProductQuantityStepper(minimum: 1).then {
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 3.0
    
    $0.delegate = self
  }
  
  private let staticTotalPriceLabel = UILabel().then {
    $0.text = "합계"
  }
  
  private let totalProductPriceLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 17, weight: .medium)
    $0.textAlignment = .right
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  private let staticWonLabel = UILabel().then {
    $0.text = "원"
  }
  
  private let bottomSeperator = UIView().then {
    $0.backgroundColor = .kurlyGray3
  }
  
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupAttribute()
    addAllView()
    setupAutoLayout()
    setupSelectedBackgroundView()
    setupContentViewBackgroundColor(.kurlyGray3)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.clipsToBounds = false
  }
  
  private func addAllView() {
    contentView.addSubview(containerView)
    
    containerView.addSubviews([
      topSeperator,
      checkBox,
      nameLabel,
      productRemoveButton,
      productImageView,
      originalPriceLabel,
      currentPriceLabel,
      productQuantityStepper,
      staticTotalPriceLabel,
      totalProductPriceLabel,
      staticWonLabel,
      bottomSeperator
    ])
  }
  
  private func setupAutoLayout() {
    containerView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(8)
    }
    
    topSeperator.snp.makeConstraints {
      $0.top.equalToSuperview().offset(-1)
      $0.leading.equalTo(productImageView)
      $0.trailing.equalTo(productQuantityStepper)
      $0.height.equalTo(1)
    }
    
    checkBox.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.leading.equalToSuperview().inset(10)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(checkBox)
      $0.leading.equalTo(checkBox.snp.trailing).offset(16)
      $0.trailing.equalTo(productRemoveButton.snp.leading).offset(-32)
    }
    
    productRemoveButton.snp.makeConstraints {
      $0.top.bottom.equalTo(checkBox)
      $0.trailing.equalToSuperview().inset(10)
      $0.width.height.equalTo(checkBox)
    }
    
    productImageView.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(12)
      $0.leading.equalTo(nameLabel)
      $0.width.equalTo(50)
      $0.height.equalTo(productImageView.snp.width).multipliedBy(1.2)
    }
    
    originalPriceLabel.snp.makeConstraints {
      $0.leading.trailing.equalTo(currentPriceLabel)
      $0.bottom.equalTo(currentPriceLabel.snp.top)
    }
    
    currentPriceLabel.snp.makeConstraints {
      $0.leading.equalTo(productImageView.snp.trailing).offset(8)
      $0.bottom.equalTo(productImageView)
    }
    
    productQuantityStepper.snp.makeConstraints {
      $0.trailing.equalTo(productRemoveButton)
      $0.bottom.equalTo(productImageView)
      $0.width.equalTo(120)
      $0.height.equalTo(productQuantityStepper.snp.width).dividedBy(3.6)
    }
    
    staticTotalPriceLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(totalProductPriceLabel)
      $0.trailing.equalTo(productQuantityStepper.snp.leading)
    }
    
    totalProductPriceLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(staticWonLabel)
      $0.leading.equalTo(productQuantityStepper)
      $0.bottom.equalToSuperview().inset(10)
      $0.trailing.equalTo(staticWonLabel.snp.leading).offset(-4)
    }
    
    staticWonLabel.snp.makeConstraints {
      $0.top.equalTo(productQuantityStepper.snp.bottom).offset(12)
      $0.trailing.equalTo(productQuantityStepper)
      $0.bottom.equalToSuperview().inset(10)
    }
    
    bottomSeperator.snp.makeConstraints {
      $0.leading.equalTo(productImageView)
      $0.bottom.equalToSuperview().offset(1)
      $0.trailing.equalTo(productQuantityStepper)
      $0.height.equalTo(1)
    }
  }
  
  private func setupContentViewBackgroundColor(_ color: UIColor) {
    contentView.backgroundColor = color
  }
  
  private func setupSelectedBackgroundView() {
    selectedBackgroundView = UIView()
  }
}

// MARK: - Action Handler

extension CartProductTableViewCell: CheckBoxDelegate {
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool) {
    deleagte?.checkBoxTouched(checkBox, isChecked, shoppingItemIndexPath)
  }
  
  @objc
  private func productRemoveButtonTouched(_ button: UIButton) {
    deleagte?.productRemoveButtonTouched(button, shoppingItemIndexPath)
  }
}

extension CartProductTableViewCell: ProductQuantityStepperDelegate {
  func valueChanged(_ value: Int) {
    deleagte?.productQuantityStepperValueChanged(value, shoppingItemIndexPath)
  }
  
  // MARK: - Element Control
  
  func configure(
    name: String, imageURL: String,
    price: Int, discount: Double,
    quantity: Int, isChecked: Bool, shoppingItemIndexPath: IndexPath
  ) {
    originalPriceLabel.isHidden = true
    if discount != 0 {
      let originalPrice = moneyFormatter(won: Int(Double(price) / (1 - discount)), hasUnit: true)
      
      originalPriceLabel.isHidden = false
      originalPriceLabel.attributedText = NSMutableAttributedString()
        .strikethrough(originalPrice, textColor: .kurlyGray1)
    }
    
    let totalPrice = moneyFormatter(won: price * quantity, hasUnit: false)
    let currentPrice = moneyFormatter(won: price, hasUnit: true)

    nameLabel.text = name
    productImageView.setImage(urlString: imageURL)
    currentPriceLabel.text = currentPrice
    totalProductPriceLabel.text = totalPrice
    productQuantityStepper.setValue(quantity)
    checkBox.setStatus(isChecked)
    self.shoppingItemIndexPath = shoppingItemIndexPath
  }
}
