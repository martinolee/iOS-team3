//
//  DeliveryNoticeView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DeliveryNoticeView: UIView {
  private let deliveryNoticeLabel = UILabel().then {
    $0.attributedText = NSMutableAttributedString()
    .bold("배송안내", fontSize: 18)
  }
  private let deliveryStackView = UIStackView().then {
    $0.axis = .vertical
    $0.spacing = 8
  }
  private let deliveryTypeArray = [" 샛별배송 ", " 택배배송 ", " 배송휴무 "]
  private let deliveryTypeContents = [
    "밤 11시까지 주문하면, 다음날 아침 7시 이전 도착\n밤 11시까지 주문하면, 다음날 아침 7시 이전 도착\n",
    "밤 8시까지 주문하면, 다음날 도착",
    "샛별배송 - 휴무없음 / 택배배송 - 일요일\n택배배송의 경우,지역에 따라\n토요일 배송이 불가할 수 있습니다."
  ]
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupAttr()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension DeliveryNoticeView {
  private func makeStackView() {
    for (idx, data) in Array(zip(deliveryTypeArray, deliveryTypeContents)).enumerated() {
      let typeLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
          .normal(data.0, textColor: .kurlyMainPurple, fontSize: 14)
        $0.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      }
      let contentLabel = UILabel().then {
        $0.attributedText = NSMutableAttributedString()
        .normal(data.1, fontSize: 14)
      }
      let innerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .top
      }
      if idx == 2 {
        typeLabel.textColor = .kurlyGray1
        contentLabel.preferredMaxLayoutWidth = 600
        contentLabel.textColor = .kurlyGray1
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
      }
      innerStackView.makeHorizontalStackView(items: [typeLabel, contentLabel])
      deliveryStackView.addArrangedSubview(innerStackView)
    }
  }
  private func setupAttr() {
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.kurlyGray2.cgColor
  }
  private func setupUI() {
    makeStackView()
    self.addSubviews([deliveryNoticeLabel, deliveryStackView])
    deliveryNoticeLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.centerX.equalToSuperview()
    }
    
    deliveryStackView.snp.makeConstraints {
      $0.top.equalTo(deliveryNoticeLabel.snp.bottom).offset(20)
      $0.bottom.equalToSuperview().inset(20)
      $0.centerX.equalToSuperview()
    }
  }
}
