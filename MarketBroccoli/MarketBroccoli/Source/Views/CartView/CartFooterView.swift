//
//  CartFooterView.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/26.
//  Copyright © 2020 Team3. All rights reserved.
//

import SnapKit
import Then
import UIKit

class CartFooterView: UIView {
  // MARK: - Properties
  
  enum UI {
    static var superviewSpacing: CGFloat {
      24
    }
    
    static var subviewSpacing: CGFloat {
      16
    }
  }
  
  private let staticTotalProductPriceLabel = UILabel().then {
    $0.text = "상품금액"
  }
  
  private let totalProductPriceLabel = UILabel().then {
    $0.textAlignment = .right
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  private let staticDiscountProductPriceLabel = UILabel().then {
    $0.text = "상품할인금액"
  }
  
  private let discountProductPriceLabel = UILabel().then {
    $0.textAlignment = .right
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  private let staticShippingFeeLabel = UILabel().then {
    $0.text = "배송비"
  }
  
  private let shippingFeeLabel = UILabel().then {
    $0.textAlignment = .right
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  private let separator = UIView().then {
    $0.backgroundColor = .lightGray
  }
  
  private let staticExpectedAmountPaymentLabel = UILabel().then {
    $0.text = "결제예정금액"
  }
  
  private let expectedAmountPaymentLabel = UILabel().then {
    $0.textAlignment = .right
    $0.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    hideAllSubviews(true)
    setupAttribute()
    addAllView()
    setupStaticViewSize()
    configure(totalProductPrice: 0, discountProductPrice: 0, shippingFee: 0, expectedAmountPayment: 0)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .white
  }
  
  private func addAllView() {
    self.addSubviews([
      staticTotalProductPriceLabel,
      totalProductPriceLabel,
      staticDiscountProductPriceLabel,
      discountProductPriceLabel,
      staticShippingFeeLabel,
      shippingFeeLabel,
      separator,
      staticExpectedAmountPaymentLabel,
      expectedAmountPaymentLabel
    ])
  }
  
  private func setupStaticViewSize() {
    [staticTotalProductPriceLabel,
     staticDiscountProductPriceLabel,
     staticShippingFeeLabel,
     staticExpectedAmountPaymentLabel].forEach {
      $0.frame.size = CGSize(width: $0.intrinsicContentSize.width, height: $0.intrinsicContentSize.height)
    }
  }
  
  private func updateLayout() {
    setupViewOrigin()
    setupViewSize()
  }
  
  private func setupViewOrigin() {
    let staticLabels = [staticTotalProductPriceLabel, staticDiscountProductPriceLabel,
                        staticShippingFeeLabel, separator, staticExpectedAmountPaymentLabel]
    let labels = [totalProductPriceLabel, discountProductPriceLabel, shippingFeeLabel,
                  separator, expectedAmountPaymentLabel]
    
    for index in 0 ..< labels.count {
      if index == 0 {
        staticLabels[index].frame.origin = CGPoint(x: UI.superviewSpacing, y: UI.superviewSpacing)
        
        labels[index].frame.origin = CGPoint(
          x: staticLabels[index].frame.maxX,
          y: staticLabels[index].frame.minY
        )
      } else if index == labels.count - 1 {
        labels[index].frame.origin = CGPoint(
          x: staticLabels[index].frame.maxX,
          y: self.bounds.maxY - (UI.superviewSpacing + labels[index].frame.height)
        )
        
        staticLabels[index].frame.origin = CGPoint(
          x: staticLabels[index - 1].frame.minX,
          y: self.bounds.maxY - (UI.superviewSpacing + staticLabels[index].frame.height)
        )
      } else {
        labels[index].frame.origin = CGPoint(
          x: staticLabels[index].frame.maxX,
          y: staticLabels[index].frame.minY
        )
        
        staticLabels[index].frame.origin = CGPoint(
          x: staticLabels[index - 1].frame.minX,
          y: staticLabels[index - 1].frame.maxY + UI.subviewSpacing
        )
      }
    }
  }
  
  private func setupViewSize() {
    let staticLabels = [staticTotalProductPriceLabel, staticDiscountProductPriceLabel,
                        staticShippingFeeLabel, staticExpectedAmountPaymentLabel]
    let labels = [totalProductPriceLabel, discountProductPriceLabel, shippingFeeLabel, expectedAmountPaymentLabel]
    
    for index in 0 ..< labels.count {
      labels[index].frame.size =
        CGSize(
          width: self.frame.width - (UI.superviewSpacing * 2 + staticLabels[index].frame.width),
          height: labels[index].intrinsicContentSize.height
      )
    }
    
    separator.frame.size = CGSize(width: self.frame.width - UI.superviewSpacing * 2, height: 1)
  }
}

// MARK: - Element Control

extension CartFooterView {
  func configure(totalProductPrice: Int, discountProductPrice: Int, shippingFee: Int, expectedAmountPayment: Int) {
    totalProductPriceLabel.attributedText = NSMutableAttributedString()
      .bold("\(moneyFormatter(won: totalProductPrice, hasUnit: false))", fontSize: 17)
      .normal(" 원", fontSize: 17)

    discountProductPriceLabel.attributedText = NSMutableAttributedString()
      .bold("\(moneyFormatter(won: discountProductPrice, hasUnit: false))", fontSize: 17)
      .normal(" 원", fontSize: 17)

    shippingFeeLabel.attributedText = NSMutableAttributedString()
      .bold("\(moneyFormatter(won: shippingFee, hasUnit: false))", fontSize: 17)
      .normal(" 원", fontSize: 17)

    expectedAmountPaymentLabel.attributedText = NSMutableAttributedString()
      .bold("\(moneyFormatter(won: expectedAmountPayment, hasUnit: false))", fontSize: 24)
      .normal(" 원", fontSize: 17)
    
    updateLayout()
  }
  
  func hideAllSubviews(_ hidden: Bool) {
    [
      staticTotalProductPriceLabel,
      totalProductPriceLabel,
      staticDiscountProductPriceLabel,
      discountProductPriceLabel,
      staticShippingFeeLabel,
      shippingFeeLabel,
      separator,
      staticExpectedAmountPaymentLabel,
      expectedAmountPaymentLabel
      ].forEach {
        $0.isHidden = hidden
    }
  }
}
