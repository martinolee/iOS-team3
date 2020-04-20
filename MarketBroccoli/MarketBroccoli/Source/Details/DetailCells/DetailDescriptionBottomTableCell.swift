//
//  DetailDescriptionBottomTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Kingfisher

class DetailDescriptionBottomTableCell: UITableViewCell {
  private let deliveryNotice = DeliveryNoticeView()
  let descriptionImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  private let summaryLabel = UILabel().then {
    $0.text = "무엇 하나 빠지지 않는 스피커"
    $0.font = .systemFont(ofSize: 22, weight: .semibold)
    $0.textColor = .darkGray
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
    $0.minimumScaleFactor = 0.6
  }
  private let nameLabel = UILabel().then {
    $0.text = "[하만카돈]\n오닉스 스튜디오5\n블루투스 스피커 2종"
    $0.font = .systemFont(ofSize: 28, weight: .semibold)
    $0.textColor = .darkGray
    $0.numberOfLines = 0
    $0.textAlignment = .center
  }
  private let seperator = Seperator()
  private let descriptionLabel = UILabel().then {
    $0.text = "풍부한 음감을 지녔으면서도 집에서 부담 없이 편하게 쓸 수 있는 첫 블루투스 스피커를 고심 중이었다면, 지금 소개하는 하만카돈의 오닉스 스튜디오5가 후회 없는 선택이 될 거예요. 오디오 명가 하만카돈 특유의 단단한 저음과 선명하고 깨끗한 고음을 오롯이 즐길 수 있죠."
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 16, weight: .thin)
    $0.textColor = .darkGray
  }
  
  private let checkPointImageView = UIImageView().then {
    $0.contentMode = . scaleAspectFit
  }
  
  private lazy var detailImageView = UIImageView().then {
    let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTouched(_:)))
    
    $0.contentMode = .scaleAspectFit
    $0.isUserInteractionEnabled = true
    $0.addGestureRecognizer(imageTap)
  }
  private let whyKurly = WhyKurlyView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    print(#function)
    setupUI()
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension DetailDescriptionBottomTableCell {
  func configure(detail model: ProductModel) {
    print(#function)
    guard let thumbImage = model.images.first(where: { $0.name == "main" }),
      let detailImage = model.images.first(where: { $0.name == "detail" })
      else { return }
//    if let checkImage = model.images.first(where: { $0.name == "check" } ) {
//      checkPointImageView.setImage(urlString: checkImage.image)
//      print(checkImage)
//      if let size = checkPointImageView.image?.size {
//        let ratio = UIScreen.main.bounds.width / size.width
//        let height = size.height * ratio
//        print(size)
//        checkPointImageView.snp.updateConstraints {
//          $0.height.equalTo(height)
//        }
//      }
//    }
    summaryLabel.text = model.summary
    nameLabel.text = model.name
    descriptionLabel.text = model.productModelDescription
    descriptionImageView.setImage(urlString: thumbImage.image)
    detailImageView.setImage(urlString: detailImage.image)
    
//    if let size = self.detailImageView.image?.size {
//      let ratio = UIScreen.main.bounds.width / size.width
//      let height = size.height * ratio
//      detailImageView.snp.remakeConstraints {
//        $0.height.equalTo(height)
//      }
//    }
  }
  
  @objc private func imageTouched(_ sender: UITapGestureRecognizer) {
    ObserverManager.shared.post(
      observerName: .imageTouched,
      object: nil,
      userInfo: ["image": detailImageView.image]
    )
  }
}

extension DetailDescriptionBottomTableCell {
  private func setupUI() {
    self.contentView.addSubviews(
      [
        deliveryNotice, descriptionImageView, summaryLabel, nameLabel,
        seperator, descriptionLabel, checkPointImageView, detailImageView, whyKurly
    ])
    deliveryNotice.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview().inset(20)
    }
    descriptionImageView.snp.makeConstraints {
      $0.top.equalTo(deliveryNotice.snp.bottom).offset(40)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(300)
    }
    
    summaryLabel.snp.makeConstraints {
      $0.top.equalTo(descriptionImageView.snp.bottom).offset(40)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(summaryLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    seperator.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(1)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(seperator.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    checkPointImageView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      $0.height.equalTo(0)
    }
    
    detailImageView.snp.makeConstraints {
      $0.top.equalTo(checkPointImageView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(800)
    }
    
    whyKurly.snp.makeConstraints {
      $0.top.equalTo(detailImageView.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
      $0.height.equalTo(600)
    }
  }
}
