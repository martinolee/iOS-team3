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
  func selectAllProductButtonTouched(_ button: UIButton)
  
  func removeSelectedProductButton(_ button: UIButton)
}

class CartViewHeader: UIView {
  // MARK: - Properties
  
  weak var delegate: CartViewHeaderDelegate?
  
  private lazy var selectAllProductButton = UIButton(type: .system).then {
    $0.contentMode = .center
    $0.tintColor = .purple
    $0.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
    
    $0.addTarget(self, action: #selector(selectAllProductButtonTouched(_:)), for: .touchUpInside)
  }
  
  private lazy var selectingStatusLabel = UILabel().then {
    $0.text = "전체선택 (6/6)"
  }
  
  private lazy var removeProductButton = UIButton(type: .system).then {
    $0.layer.borderColor = UIColor.gray.cgColor
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
    makeRoundCorner(selectAllProductButton, radius: 6)
    makeRoundCorner(removeProductButton, radius: 6)
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .lightGray
  }
  
  private func addAllView() {
    self.addSubviews([
      selectAllProductButton,
      selectingStatusLabel,
      removeProductButton
    ])
  }
  
  private func setupAutoLayout() {
    selectAllProductButton.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(18)
      $0.centerY.equalToSuperview()
      $0.width.equalTo(25)
      $0.height.equalTo(selectAllProductButton.snp.width)
    }
    
    selectingStatusLabel.snp.makeConstraints {
      $0.centerY.equalTo(selectAllProductButton)
      $0.leading.equalTo(selectAllProductButton.snp.trailing).offset(20)
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
  
  // MARK: - Action Handler
  
  @objc
  private func selectAllProductButtonTouched(_ button: UIButton) {
    delegate?.selectAllProductButtonTouched(button)
  }
  
  @objc
  private func removeSelectedProductButton(_ button: UIButton) {
    delegate?.removeSelectedProductButton(button)
  }
}
