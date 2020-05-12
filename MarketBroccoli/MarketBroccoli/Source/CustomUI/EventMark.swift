//
//  EventMark.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class EventMark: UIView {
  let textLabel = UILabel().then {
    $0.numberOfLines = 2
    $0.textColor = .white
    $0.font = .systemFont(ofSize: 10, weight: .bold)
    $0.textAlignment = .center
    $0.adjustsFontSizeToFitWidth = true
    $0.minimumScaleFactor = 0.2
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setAttr()
  }
  
  convenience init(text: String) {
    self.init()
    textLabel.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension EventMark {
  private func setAttr() {
    self.backgroundColor = UIColor.kurlyPurple1.withAlphaComponent(0.7)
  }
  private func setupUI() {
    self.addSubview(textLabel)
    textLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
