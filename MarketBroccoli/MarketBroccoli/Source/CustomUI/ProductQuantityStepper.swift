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
  func subtractionButtonTouched(_ button: UIButton, _ valueLabel: UILabel)
  
  func additionButtonTouched(_ button: UIButton, _ valueLabel: UILabel)
}

class ProductQuantityStepper: UIView {
  // MARK: - Properties
  
  weak var delegate: ProductQuantityStepperDelegate?
  
  private lazy var subtractionButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .purple
    $0.backgroundColor = .lightGray
    $0.setImage(UIImage(systemName: "plus"), for: .normal)
    
    $0.addTarget(self, action: #selector(subtractionButtonTouched(_:)), for: .touchUpInside)
  }
  
  private lazy var valueLabel = UILabel().then {
    $0.textAlignment = .center
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.gray.cgColor
  }
  
  private lazy var additionButton = UIButton(type: .system).then {
    $0.contentMode = .scaleAspectFit
    $0.tintColor = .purple
    $0.backgroundColor = .lightGray
    $0.setImage(UIImage(systemName: "minus"), for: .normal)
    
    $0.addTarget(self, action: #selector(additionButtonTouched(_:)), for: .touchUpInside)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllView()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
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
  private func subtractionButtonTouched(_ button: UIButton) {
    delegate?.subtractionButtonTouched(button, valueLabel)
  }
  
  @objc
  private func additionButtonTouched(_ button: UIButton) {
    delegate?.additionButtonTouched(button, valueLabel)
  }
  
  // MARK: - Element Control
  
  func setValueLabel(text: String) { valueLabel.text = text }
}
