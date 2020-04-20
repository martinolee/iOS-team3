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
    $0.contentMode = .scaleToFill
  }
  private let titleLabel = UILabel().then {
    $0.text = "[앤블랭크] 노즈워크 토이 2종"
    $0.font = .systemFont(ofSize: 20, weight: .semibold)
  }
  private let subtitleLabel = UILabel().then {
    $0.text = "활용도가 다양한 올인원 장난감"
    $0.textColor = .kurlyGray1
    $0.numberOfLines = 2
  }
  private let shareBtn = UIButton()

  private let priceStackView = PriceStackView(isLogin: false, isDiscount: false).then {
    $0.axis = .vertical
    $0.spacing = 8
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

// MARK: - ACTIONS
extension DetailDescriptionTopTableCell {
  func configure(detail model: ProductModel) {
    guard let mainImage = model.images.first(where: { $0.name == "thumb" }) else { return }
    titleLabel.text = model.name
    subtitleLabel.text = model.summary
    mainImageView.setImage(urlString: mainImage.image)
    (infoStackView.viewWithTag(9999) as? UILabel)?.text = model.unit
    (infoStackView.viewWithTag(9998) as? UILabel)?.text = model.amount
    (infoStackView.viewWithTag(9997) as? UILabel)?.text = model.madeIn
    (infoStackView.viewWithTag(9996) as? UILabel)?.text = model.package
  }
}

// MARK: - UI
extension DetailDescriptionTopTableCell {
  private func makeinfoStackView() {
    let textArray = infoDummy.compactMap { text -> CGFloat? in
      let label = UILabel()
      label.text = text
      return label.getWidth()
    }
    for (idx, text) in infoDummy.enumerated() {
      let infolabel = UILabel().then { lbl in
        lbl.text = text
        lbl.snp.makeConstraints { make in
          make.width.equalTo((textArray.max() ?? 0) + 10)
        }
      }
      
      let infoTextLabel = UILabel().then { lbl in
        lbl.text = ""
        lbl.tag = 9999 - idx
      }
      
      let innerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 16
      }
      
      innerStackView.addArrangedSubview(infolabel)
      innerStackView.addArrangedSubview(infoTextLabel)
      self.infoStackView.addArrangedSubview(innerStackView)
    }
  }
  
  private func setupUI() {
    makeinfoStackView()
    self.addSubviews([mainImageView, descriptionTopView, priceStackView, seperator, infoStackView])
    descriptionTopView.addSubviews([titleLabel, subtitleLabel])
    mainImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(400)
    }
    
    descriptionTopView.snp.makeConstraints {
      $0.top.equalTo(mainImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    subtitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(20)
    }
    
    priceStackView.snp.makeConstraints {
    $0.top.equalTo(descriptionTopView.snp.bottom)
    $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
    
    seperator.snp.makeConstraints {
      $0.top.equalTo(priceStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(1)
    }
    
    infoStackView.snp.makeConstraints {
      $0.top.equalTo(seperator.snp.bottom).offset(20)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0))
    }
  }
}
