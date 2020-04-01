//
//  SignupLabel.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/01.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SignupLabel: UILabel {
  var required: Bool = false
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(textColor: UIColor?, font: UIFont?) {
    self.init()
    if textColor != nil {
      self.textColor = textColor
    }
    if font != nil {
      self.font = font
    }
    if required {
      self.attributedText = putAsteriskBehind(self.text ?? "")
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SignupLabel {
  private func putAsteriskBehind(_ text: String) -> NSMutableAttributedString {
    let myMutableString = NSMutableAttributedString(string: "\(text)*", attributes: nil)
    myMutableString.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: UIColor.kurlyPurple, range: NSRange(location: text.count, length: 1)
    )
    return myMutableString
  }
}
