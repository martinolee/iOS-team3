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
    self.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
    self.backgroundColor = .kurlyMainPurple
    self.layer.cornerRadius = 4
  }
  
  func roundLineBtnStyle() {
    self.setTitleColor(.kurlyMainPurple, for: .normal)
    self.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
    self.backgroundColor = .white
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.kurlyMainPurple.cgColor
    self.layer.cornerRadius = 4
  }
  
  func makeCircleButton() {
    self.layer.masksToBounds = true
    self.layer.cornerRadius = self.bounds.height / 2
  }
}
