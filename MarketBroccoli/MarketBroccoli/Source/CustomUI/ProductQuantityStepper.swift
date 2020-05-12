//
//  ProductCountStepper.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import Then
import UIKit

protocol ProductQuantityStepperDelegate: class {
  func valueChanged(_ value: Int)
}

class ProductQuantityStepper: UIView {
  // MARK: - Properties
  
  weak var delegate: ProductQuantityStepperDelegate?
  
  private var minimum: Int
  
  private var value = 0 {
    didSet {
      valueLabel.text = "\(value)"
    }
  }
  
  private lazy var subtractionButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .kurlyMainPurple
    $0.backgroundColor = .kurlyGray3
    $0.setImage(UIImage(systemName: "minus"), for: .normal)
    
    $0.addTarget(self, action: #selector(subtractValue), for: .touchUpInside)
  }
  
  private lazy var valueLabel = UILabel().then {
    $0.textAlignment = .center
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.kurlyGray2.cgColor
  }
  
  private lazy var additionButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .kurlyMainPurple
    $0.backgroundColor = .kurlyGray3
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
    
    $0.addTarget(self, action: #selector(addValue), for: .touchUpInside)
  }
  
  // MARK: - Life Cycle
  
  private override init(frame: CGRect) {
    minimum = 0
    super.init(frame: frame)
    
    setupAttribute()
    addAllView()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(minimum: Int) {
    self.init()
    
    self.minimum = minimum
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.do {
      $0.layer.borderColor = UIColor.kurlyGray2.cgColor
      $0.layer.borderWidth = 1
    }
  }
  
  private func addAllView() {
    self.addSubviews([
      subtractionButton,
      valueLabel,
      additionButton
    ])
  }
  
  private func setupAutoLayout() {
    subtractionButton.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.25)
    }
    
    valueLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(subtractionButton.snp.trailing)
      $0.trailing.equalTo(additionButton.snp.leading)
    }
    
    additionButton.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.25)
    }
  }
  
  // MARK: - Action Handler
  
  @objc
  private func subtractValue() {
    if value > minimum {
      value -= 1
      
      delegate?.valueChanged(value)
    }
  }
  
  @objc
  private func addValue() {
    value += 1
    
    delegate?.valueChanged(value)
  }
  
  // MARK: - Element Control
  
  func setValue(_ value: Int) {
    self.value = value
  }
}
