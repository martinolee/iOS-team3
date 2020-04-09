//
//  WhyKurlyView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/08.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class WhyKurlyView: UIView {
  private let whyKurly = UILabel().then {
    $0.text = "WHY KURLY"
    $0.textColor = .darkGray
    $0.font = .systemFont(ofSize: 20)
  }
  private let seperator = Seperator()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension WhyKurlyView {
  private func makeInnerView(icon: [UIImage], title: [String], description: [String]) -> [UIView] {
    let returnUIArray = zip(icon, zip(title, description)).map { (arg) -> UIView in
      let (icon, data) = arg
      let containerView = UIView()
      let imageView = UIImageView().then {
        $0.image = icon
      }
      let titleLabel = UILabel().then {
        $0.text = data.0
        $0.textColor = .kurlyMainPurple
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
      }
      let descriptionLabel = UILabel().then {
        $0.text = data.1
        $0.numberOfLines = 0
        $0.font = .systemFont(ofSize: 14)
      }
      containerView.addSubviews([imageView, titleLabel, descriptionLabel])
      
      imageView.snp.makeConstraints {
        $0.top.leading.equalToSuperview()
        $0.width.height.equalTo(40)
      }
      
      titleLabel.snp.makeConstraints {
        $0.leading.equalTo(imageView.snp.trailing).offset(20)
        $0.trailing.equalToSuperview().offset(20)
        $0.bottom.equalTo(imageView.snp.centerY)
      }
      
      descriptionLabel.snp.makeConstraints {
        $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        $0.bottom.equalToSuperview()
        $0.leading.equalTo(titleLabel.snp.leading)
        $0.trailing.equalToSuperview().offset(20)
      }
      return containerView
    }
    return returnUIArray
  }
  
  private func setupUI() {
    let innerViews = makeInnerView(
      icon: WhyKurly.icons,
      title: WhyKurly.titles,
      description: WhyKurly.descriptions
    )

    self.addSubviews([whyKurly, seperator])
    whyKurly.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
    }
    
    seperator.snp.makeConstraints {
      $0.leading.equalTo(whyKurly.snp.trailing).offset(10)
      $0.trailing.equalToSuperview()
      $0.centerY.equalTo(whyKurly)
      $0.height.equalTo(1)
    }
    
    for (idx, innerView) in innerViews.enumerated() {
      self.addSubview(innerView)
      innerView.snp.makeConstraints {
      if idx == 0 {
          $0.top.equalTo(whyKurly.snp.bottom).offset(20)
      } else if idx == innerViews.count {
            $0.top.equalTo(innerViews[idx - 1].snp.bottom).offset(20)
            $0.bottom.equalToSuperview()
      } else {
          $0.top.equalTo(innerViews[idx - 1].snp.bottom).offset(20)
      }
        $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20))
      }
    }
  }
}
