//
//  CartTableViewHeader.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/26.
//  Copyright © 2020 Team3. All rights reserved.
//

import SnapKit
import Then
import UIKit

protocol CartViewHeaderDelegate: class {
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, isChecked: Bool)
  
  func removeSelectedProductButton(_ button: UIButton)
}

class CartViewHeader: UIView {
  // MARK: - Properties
  
  weak var delegate: CartViewHeaderDelegate?
  
  private lazy var selectAllProductCheckBox = CheckBox(type: .system).then {
    $0.delegate = self
  }
  
  private lazy var selectingStatusLabel = UILabel().then {
    $0.text = "전체선택 (0/0)"
  }
  
  private lazy var removeProductButton = UIButton(type: .system).then {
    $0.layer.borderColor = UIColor.kurlyGray1.cgColor
    $0.layer.borderWidth = 1
    $0.titleLabel?.font = .systemFont(ofSize: 15, weight: .light)
    $0.setTitleColor(.black, for: .normal)
    $0.backgroundColor = .white
    $0.setTitle("선택삭제", for: .normal)
    
    $0.addTarget(self, action: #selector(removeSelectedProductButton(_:)), for: .touchUpInside)
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
  
  override func layoutSubviews() {
    makeRoundCorner(selectAllProductCheckBox, radius: 6)
    makeRoundCorner(removeProductButton, radius: 6)
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .kurlyGray3
  }
  
  private func addAllView() {
    self.addSubviews([
      selectAllProductCheckBox,
      selectingStatusLabel,
      removeProductButton
    ])
  }
  
  private func setupAutoLayout() {
    selectAllProductCheckBox.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(18)
      $0.centerY.equalToSuperview()
      $0.width.equalTo(25)
      $0.height.equalTo(selectAllProductCheckBox.snp.width)
    }
    
    selectingStatusLabel.snp.makeConstraints {
      $0.centerY.equalTo(selectAllProductCheckBox)
      $0.leading.equalTo(selectAllProductCheckBox.snp.trailing).offset(16)
    }
    
    removeProductButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(12)
      $0.leading.equalTo(selectingStatusLabel.snp.trailing)
      $0.trailing.equalToSuperview().inset(16)
      $0.width.equalTo(60)
    }
  }
  
  private func makeRoundCorner(_ view: UIView, radius: CGFloat) {
    view.layer.masksToBounds = true
    view.layer.cornerRadius = radius
  }
}

// MARK: - Action Handler

extension CartViewHeader: CheckBoxDelegate {
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool) {
    delegate?.selectAllProductCheckBoxTouched(checkBox, isChecked: isChecked)
  }
  
  @objc
  private func removeSelectedProductButton(_ button: UIButton) {
    delegate?.removeSelectedProductButton(button)
  }
}

// MARK: - Element Control

extension CartViewHeader {
  func setSelectAllProductCheckBoxStatus(_ checked: Bool) {
    selectAllProductCheckBox.setStatus(checked)
  }
}
