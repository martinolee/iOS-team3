//
//  UIStackViewExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIStackView {
  func makeHorizontalStackView(items: [UIView]) {
    self.axis = .horizontal
    items.forEach {
      self.addArrangedSubview($0)
    }
  }
}
