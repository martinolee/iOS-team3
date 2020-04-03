//
//  CategoryStackView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/02.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryStackView: UIStackView {
  private let stackViewBackground = UIView().then {
    $0.backgroundColor = .white
  }
  
  init(categories: [String], distribution: UIStackView.Distribution) {
    super.init(frame: .zero)
    self.axis = .horizontal
    self.spacing = 8
    self.distribution = distribution
    
    for (idx, text) in categories.enumerated() {
      let label = UILabel().then {
        $0.text = text
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 18)
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = true
        $0.tag = 9999 - idx
      }
      self.addArrangedSubview(label)
    }
    self.insertSubview(stackViewBackground, at: 0)
    setupUI()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CategoryStackView {
  private func setupUI() {
    stackViewBackground.snp.makeConstraints {
      $0.edges.equalTo(self)
      $0.height.equalTo(40)
    }
  }
}
