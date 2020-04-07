//
//  SignupButton.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/01.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SignupButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(setTitleColor: UIColor?, backgroundColor: UIColor?, borderWidth: CGFloat?, borderColor: CGColor?) {
    self.init()
    if setTitleColor != nil {
      self.setTitleColor(setTitleColor, for: .normal)
    }
    if backgroundColor != nil {
      self.backgroundColor = backgroundColor
    }
    if borderWidth != nil {
      self.layer.borderWidth = borderWidth ?? 0
    }
    if borderColor != nil {
      self.layer.borderColor = borderColor
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
