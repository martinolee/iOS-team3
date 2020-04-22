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
    Developers(name: "신동현", github: ""),
    Developers(name: "권은비", github: "")]
  private let iOS = [
    Developers(name: "홍동현", github: ""),
    Developers(name: "이수한", github: ""),
    Developers(name: "안지현", github: ""),
    Developers(name: "이희진", github: "")]
  
  private let developersLabel = UILabel().then {
    $0.text = "개발자 소개"
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

extension EasterEggTableCell {
  private func setupAttr() {
    self.backgroundColor = .kurlyGray1
  }
  private func setupUI() {
    self.contentView.addSubviews([developersLabel])
    
    developersLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
