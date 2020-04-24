//
//  SelectingProductCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol SelectingProductCellDelegate: class {
  func productQuantityStepperValueChanged(_ value: Int, _ productIndexPath: IndexPath)
}

class SelectingProductCell: UITableViewCell {
  // MARK: - Properties
  
  weak var delegate: SelectingProductCellDelegate?
  
  private let containerView = UIView().then {
    $0.backgroundColor = .white
  }
  
  private var productIndexPath: IndexPath!
  
  private let nameLabel = UILabel().then {
    $0.numberOfLines = 2
  }
  
  private let priceLabel = UILabel()
  
  private lazy var productQuantityStepper = ProductQuantityStepper(minimum: 0).then {
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 3.0
    
    $0.delegate = self
  }
  
  private let seperator = UIView().then {
    $0.backgroundColor = .kurlyGray3
  }
  
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupAttribute()
    addAllViews()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    contentView.backgroundColor = .kurlyGray3
  }
  
  private func addAllViews() {
    contentView.addSubview(containerView)
    
    containerView.addSubviews([
      nameLabel,
      priceLabel,
      productQuantityStepper,
      seperator
    ])
  }
  
  private func setupAutoLayout() {
    containerView.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(8)
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(8)
    }
    
    priceLabel.snp.makeConstraints {
      $0.leading.equalTo(nameLabel)
      $0.bottom.equalTo(productQuantityStepper)
    }
    
    productQuantityStepper.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(nameLabel)
      $0.bottom.equalToSuperview().inset(10)
      $0.width.equalTo(100)
      $0.height.equalTo(productQuantityStepper.snp.width).dividedBy(3.6)
    }
    
    seperator.snp.makeConstraints {
      $0.leading.trailing.equalTo(nameLabel)
      $0.bottom.equalToSuperview()
      $0.height.equalTo(1)
    }
  }
}

extension SelectingProductCell: ProductQuantityStepperDelegate {
  func valueChanged(_ value: Int) {
    delegate?.productQuantityStepperValueChanged(value, productIndexPath)
  }
}

extension SelectingProductCell {
  func configure(name: String, price: Int, discount: Double, quantity: Int, productIndexPath: IndexPath) {
    let currentPrice = moneyFormatter(won: price, hasUnit: true)
    
    if discount != 0 {
      let originalPrice = moneyFormatter(won: Int(Double(price) / (1 - discount)), hasUnit: true)
      
      priceLabel.attributedText = NSMutableAttributedString()
        .strikethrough(currentPrice, textColor: .kurlyGray1)
        .normal(originalPrice, fontSize: 17)
    }
    
    nameLabel.text = name
    priceLabel.attributedText = NSMutableAttributedString()
      .normal(currentPrice, fontSize: 17)
    productQuantityStepper.setValue(quantity)
    self.productIndexPath = productIndexPath
  }
}
