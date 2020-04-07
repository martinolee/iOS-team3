//
//  DetailDescriptionTopTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailDescriptionTopTableCell: UITableViewCell {
  private let mainImageView = UIImageView().then {
    $0.image = UIImage(named: "cloud")
  }
  private let titleLabel = UILabel().then {
    $0.text = "[앤블랭크] 노즈워크 토이 2종"
  }
  private let subtitleLabel = UILabel().then {
    $0.text = "활용도가 다양한 올인원 장난감"
    $0.textColor = .kurlyGray1
  }
  private let shareBtn = UIButton()
  private let priceStackView = UIStackView().then {
    $0.axis = .vertical
  }
  
  private let descriptionTopView = UIView()
  private let seperator = Seperator()
  private let infoStackView = UIStackView().then {
    $0.axis = .vertical
  }
  private let infoDummy = ["판매단위", "중량/용량", "원산지", "포장타입"]
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  private let isLogin = false
  private let isDiscount = true
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension DetailDescriptionTopTableCell {
  private func makeinfoStackView() {
    var titles = [UILabel]()
    let asd = infoDummy.compactMap { text -> CGFloat? in
      let label = UILabel()
      label.text = text
      return label.getWidth()
    }
    infoDummy.forEach { text in
      let infolabel = UILabel().then { lbl in
        lbl.text = text
        titles.append(lbl)
      }
      let infoTextLabel = UILabel().then { lbl in
        lbl.text = "1개"
      }
      let innerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
      }
      titles.forEach {
        $0.snp.makeConstraints { layout in
          layout.width.equalTo((asd.max() ?? 0) + 10)
        }
      }
      innerStackView.addArrangedSubview(infolabel)
      innerStackView.addArrangedSubview(infoTextLabel)
      self.infoStackView.addArrangedSubview(innerStackView)
    }
  }
  private func makePriceStackView() {
    let descriptionLabel = UILabel().then {
      $0.text = "회원할인가"
      $0.accessibilityIdentifier = "discountLabel"
    }
    let priceLabel = UILabel().then {
      $0.attributedText = NSMutableAttributedString()
        .bold("2,185", fontSize: 17)
        .normal("원 ", fontSize: 13)
        .normal("5%", textColor: .red, fontSize: 17)
    }
    let beforePriceBtn = UIButton().then {
      $0.setAttributedTitle(NSMutableAttributedString().strikethrough("2300원", textColor: .kurlyGray1), for: .normal)
      $0.tintColor = .kurlyGray1
      $0.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
      $0.semanticContentAttribute = .forceRightToLeft
      $0.contentHorizontalAlignment = .left
    }
    priceStackView.addArrangedSubview(descriptionLabel)
    priceStackView.addArrangedSubview(priceLabel)
    priceStackView.addArrangedSubview(beforePriceBtn)
    if isLogin {
      let loginDescription = UIStackView().then {
        let button = UIButton().then { btn in
          btn.setTitle(" 웰컴 5% ", for: .normal)
          btn.setTitleColor(.gray, for: .normal)
          btn.layer.borderWidth = 1
          btn.layer.cornerRadius = 5
        }
        let mileageLabel = UILabel().then { lbl in
          lbl.attributedText = NSMutableAttributedString()
            .normal("개당 ", fontSize: 13)
            .normal("109원 적립", textColor: .red, fontSize: 17)
        }
        mileageLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        $0.makeHorizontalStackView(items: [button, mileageLabel])
        $0.spacing = 4
        $0.distribution = .fill
      }
      priceStackView.addArrangedSubview(loginDescription)
    } else {
      let loginDescription = UILabel().then {
        $0.textColor = .kurlyMainPurple
      }
      if isDiscount {
        loginDescription.text = "로그인 후, 회원할인가와 적립혜택이 제공됩니다."
      } else {
        loginDescription.text = "로그인 후, 적립혜택이 제공됩니다."
      }
      priceStackView.addArrangedSubview(loginDescription)
    }
  }
  
  private func setupUI() {
    self.addSubviews([mainImageView, descriptionTopView, seperator, infoStackView])
    descriptionTopView.addSubviews([titleLabel, subtitleLabel, priceStackView])
    makePriceStackView()
    makeinfoStackView()
    mainImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
    
    descriptionTopView.snp.makeConstraints {
      $0.top.equalTo(mainImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    subtitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    priceStackView.snp.makeConstraints {
      $0.top.equalTo(subtitleLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
    
    seperator.snp.makeConstraints {
      $0.top.equalTo(descriptionTopView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(1)
    }
    
    infoStackView.snp.makeConstraints {
      $0.top.equalTo(seperator.snp.bottom).offset(20)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
  }
}
