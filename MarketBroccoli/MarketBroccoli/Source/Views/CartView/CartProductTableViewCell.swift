//
//  CartProductTableViewCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import Then
import UIKit

protocol CartProductTableViewCellDelegate: class {
  func whenSelectingOptionButtonDidTouchUpInside(_ button: UIButton)
  
  func whenProductRemoveButtonDidTouchUpInside(_ button: UIButton)
  
  func whenSubtractionButtonDidTouchUpInside(_ button: UIButton)
  
  func whenAdditionButtonDidTouchUpInside(_ button: UIButton)
}

class CartProductTableViewCell: UITableViewCell {
  // MARK: - Properties
  
  weak var deleagte: CartProductTableViewCellDelegate?
  
  private let containerView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private lazy var selectingOptionButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .purple
    $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    
    $0.addTarget(self, action: #selector(whenSelectingOptionButtonDidTouchUpInside(_:)), for: .touchUpInside)
  }
  
  private lazy var nameLabel = UILabel().then {
    $0.textAlignment = .left
    $0.numberOfLines = 0
  }
  
  private lazy var productRemoveButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .black
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    
    $0.addTarget(self, action: #selector(whenProductRemoveButtonDidTouchUpInside(_:)), for: .touchUpInside)
  }
  
  private let productImageView = UIImageView().then {
    $0.image = UIImage()
  }
  
  private let originalPriceLabel = UILabel().then {
    $0.textAlignment = .left
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 15)
  }
  
  private let currentPriceLabel = UILabel().then {
    $0.textAlignment = .left
  }
  
  private lazy var productQuantityStepper = ProductQuantityStepper().then {
    $0.delegate = self
    $0.layer.borderColor = UIColor.gray.cgColor
    $0.layer.borderWidth = 1
  }
  
  private let staticTotalPriceLabel = UILabel().then {
    $0.text = "합계"
  }
  
  private let totalProductPriceLabel = UILabel().then {
    $0.textAlignment = .right
  }
  
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addAllView()
    setupAutoLayout()
    setupSelectedBackgroundView()
    setupContentViewBackgroundColor(.lightGray)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    makeRoundProductQunantityStepper()
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    contentView.addSubview(containerView)
    
    containerView.addSubviews([
      selectingOptionButton,
      nameLabel,
      productRemoveButton,
      productImageView,
      originalPriceLabel,
      currentPriceLabel,
      productQuantityStepper,
      staticTotalPriceLabel,
      totalProductPriceLabel
    ])
  }
  
  private func setupAutoLayout() {
    containerView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(4)
      $0.leading.trailing.equalToSuperview().inset(8)
    }
    
    selectingOptionButton.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16)
      $0.leading.equalToSuperview().inset(10)
      $0.width.equalTo(25)
      $0.height.equalTo(selectingOptionButton.snp.width)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(selectingOptionButton)
      $0.leading.equalTo(selectingOptionButton.snp.trailing).offset(16)
      $0.trailing.equalTo(productRemoveButton.snp.leading).offset(-32)
    }
    
    productRemoveButton.snp.makeConstraints {
      $0.top.bottom.equalTo(selectingOptionButton)
      $0.trailing.equalToSuperview().inset(10)
      $0.width.height.equalTo(selectingOptionButton)
    }
    
    productImageView.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(12)
      $0.leading.equalTo(nameLabel)
      $0.width.equalTo(50)
      $0.height.equalTo(productImageView.snp.width).multipliedBy(1.2)
    }; productImageView.backgroundColor = .gray
    
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
      $0.top.equalTo(productQuantityStepper.snp.bottom).offset(12)
      $0.leading.trailing.equalTo(productQuantityStepper)
      $0.bottom.equalToSuperview().inset(10)
    }
  }
  
  private func setupContentViewBackgroundColor(_ color: UIColor) {
    contentView.backgroundColor = color
  }
  
  private func setupSelectedBackgroundView() {
    selectedBackgroundView = UIView()
  }
  
  private func makeRoundProductQunantityStepper() {
    productQuantityStepper.layer.masksToBounds = true
    productQuantityStepper.layer.cornerRadius = 3.0
  }
  
  // MARK: - Action Handler
  
  @objc
  private func whenSelectingOptionButtonDidTouchUpInside(_ button: UIButton) {
    deleagte?.whenSelectingOptionButtonDidTouchUpInside(button)
  }
  
  @objc
  private func whenProductRemoveButtonDidTouchUpInside(_ button: UIButton) {
    deleagte?.whenProductRemoveButtonDidTouchUpInside(button)
  }
}

extension CartProductTableViewCell: ProductQuantityStepperDelegate {
  func whenSubtractionButtonDidTouchUpInside(_ button: UIButton) {
    deleagte?.whenSubtractionButtonDidTouchUpInside(button)
  }
  
  func whenAdditionButtonDidTouchUpInside(_ button: UIButton) {
    deleagte?.whenAdditionButtonDidTouchUpInside(button)
  }
  
  // MARK: - Element Control
  
  func configure(name: String, originalPrice: Int?, currentPrice: Int) {
    nameLabel.text = name
    if let originalPrice = originalPrice {
      let originalPrice = moneyFormatter(won: originalPrice, hasUnit: true)
      let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: originalPrice)
      attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1,
                                   range: NSRange(location: 0, length: attributeString.length))
      originalPriceLabel.attributedText = attributeString
    }
    
    let currentPrice = moneyFormatter(won: currentPrice, hasUnit: true)
    currentPriceLabel.text = currentPrice
    
    totalProductPriceLabel.text = currentPrice
  }
}
