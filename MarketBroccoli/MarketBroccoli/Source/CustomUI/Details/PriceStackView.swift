//
//  PriceStackView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PriceStackView: UIStackView {
  private let descriptionLabel = UILabel().then {
    $0.text = "회원할인가"
  }
  private let priceLabel = UILabel().then {
    $0.attributedText = NSMutableAttributedString()
    .bold("2,185", fontSize: 17)
    .normal("원 ", fontSize: 13)
    .normal("5%", textColor: .red, fontSize: 17)
  }
  private let beforePriceBtn = UIButton().then {
    $0.setAttributedTitle(NSMutableAttributedString().strikethrough("2300원", textColor: .kurlyGray1), for: .normal)
    $0.tintColor = .kurlyGray1
    $0.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    $0.semanticContentAttribute = .forceRightToLeft
    $0.contentHorizontalAlignment = .left
  }
  private let welcomeStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.spacing = 8
  }
  private let welcomeBtn = UIButton().then {
    $0.setTitle(" 웰컴 5% ", for: .normal)
    $0.setTitleColor(.gray, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 15)
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.kurlyGray1.cgColor
    $0.layer.cornerRadius = 12
    $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
  private let mileageLabel = UILabel().then {
    $0.attributedText = NSMutableAttributedString()
    .normal("개당 ", fontSize: 15)
    .bold("109원 적립", fontSize: 15)
  }
  private let loginDescriptionLabel = UILabel().then {
    $0.textColor = .kurlyMainPurple
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    welcomeStackView.makeHorizontalStackView(items: [welcomeBtn, mileageLabel])
    [descriptionLabel, priceLabel, beforePriceBtn, welcomeStackView, loginDescriptionLabel].forEach {
      self.addArrangedSubview($0)
    }
  }
  
  convenience init(isLogin: Bool, isDiscount: Bool) {
    self.init()
    if isLogin {
      removeElement(loginDescriptionLabel)
      if !isDiscount {
        removeElement([descriptionLabel, beforePriceBtn])
      }
    } else {
      removeElement(welcomeStackView)
      if isDiscount {
        loginDescriptionLabel.text = "로그인 후, 회원할인가와 적립혜택이 제공됩니다."
      } else {
        removeElement([descriptionLabel, beforePriceBtn])
        loginDescriptionLabel.text = "로그인 후, 적립혜택이 제공됩니다."
      }
    }
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PriceStackView {
  private func removeElement(_ element: UIView) {
    self.removeArrangedSubview(element)
    element.removeFromSuperview()
  }
  
  private func removeElement(_ element: [UIView]) {
    element.forEach {
      self.removeArrangedSubview($0)
      $0.removeFromSuperview()
    }
  }
}
