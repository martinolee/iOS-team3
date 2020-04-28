//
//  EasterEggTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class EasterEggTableCell: UITableViewCell {
  private let backend = [
    Developers(name: "신동현", github: "https://github.com/qu3vipon"),
    Developers(name: "권은비", github: "https://github.com/eunbiviakwon")
  ]
  private let iOS = [
    Developers(name: "홍동현", github: "https://github.com/hongdonghyun"),
    Developers(name: "이수한", github: "https://github.com/martinolee"),
    Developers(name: "안지현", github: "https://github.com/Lance-ahn"),
    Developers(name: "이희진", github: "https://github.com/foxwavez")
  ]
  private let customContentView = UIView()
  private let developersLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14)
    $0.text = "개발자 소개"
    $0.textColor = .kurlyGray1
  }
  private let projectLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14)
    $0.text = "프로젝트 소개"
    $0.textColor = .kurlyGray1
  }
  private let developPeriod = UILabel().then {
    $0.font = .systemFont(ofSize: 14)
    $0.text = "개발 기간: 2020.03.20 ~ 2020.04.29"
    $0.textColor = .darkGray
  }
  private lazy var marketBroccoli = LinkLabel().then {
    $0.attributedText = NSMutableAttributedString().underline("마켓브로콜리 Github", fontSize: 14)
    $0.link = "https://github.com/iOS-WPS-Team3"
    $0.textColor = .link

    let tap = UITapGestureRecognizer(target: self, action: #selector(gotoURL(_:)))
    $0.isUserInteractionEnabled = true
    $0.addGestureRecognizer(tap)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupAttr()
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension EasterEggTableCell {
  @objc private func gotoURL(_ sender: UITapGestureRecognizer) {
    guard let label = sender.view as? LinkLabel,
      let url = URL(string: label.link) else { return }
    print(label.link)
    UIApplication.shared.open(url)
  }
}

// MARK: - UI
extension EasterEggTableCell {
  private func makeDeveloperStackView(developers: [Developers]) -> UIStackView {
    let stackView = UIStackView().then {
      $0.axis = .horizontal
      $0.distribution = .fillEqually
    }
    developers.forEach { dev in
      let tap = UITapGestureRecognizer(target: self, action: #selector(gotoURL(_:)))
      let label = LinkLabel().then {
        $0.isUserInteractionEnabled = true
        $0.attributedText = NSMutableAttributedString().underline(dev.name, fontSize: 17)
        $0.link = dev.github
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
        $0.addGestureRecognizer(tap)
      }
      stackView.addArrangedSubview(label)
    }
    return stackView
  }
  private func setupAttr() {
    self.backgroundColor = .kurlyGray3
  }
  private func setupUI() {
    let backendStackView = makeDeveloperStackView(developers: backend)
    let iOSStackView = makeDeveloperStackView(developers: iOS)
    self.contentView.addSubviews([customContentView])
    self.customContentView.addSubviews(
      [developersLabel, backendStackView, iOSStackView,
       projectLabel, marketBroccoli, developPeriod])
    customContentView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 20))
    }
    developersLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
    }
    
    backendStackView.snp.makeConstraints {
      $0.top.equalTo(developersLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
    }
    
    iOSStackView.snp.makeConstraints {
      $0.top.equalTo(backendStackView.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
    }
    
    projectLabel.snp.makeConstraints {
      $0.top.equalTo(iOSStackView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
    }
    
    marketBroccoli.snp.makeConstraints {
      $0.top.equalTo(projectLabel.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
    }
    
    developPeriod.snp.makeConstraints {
      $0.top.equalTo(marketBroccoli.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
    }
  }
}
