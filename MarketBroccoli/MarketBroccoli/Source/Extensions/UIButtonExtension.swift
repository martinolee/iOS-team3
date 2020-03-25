//
//  UIButtonExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIButton {
  func roundPurpleBtnStyle() {
    self.setTitleColor(.white, for: .normal)
    self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    self.backgroundColor = .kurlyPurple
    self.layer.cornerRadius = 4
  }
  
  func roundLineBtnStyle() {
    self.setTitleColor(.kurlyPurple, for: .normal)
    self.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    self.backgroundColor = .white
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.kurlyPurple.cgColor
    self.layer.cornerRadius = 4
  }
}
