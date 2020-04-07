//
//  StringExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
  func bold(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
    let attrs = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: fontSize)]
    self.append(NSMutableAttributedString(string: text, attributes: attrs))
    return self
  }
  
  func normal(_ text: String, textColor: UIColor? = .black, fontSize: CGFloat) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
      NSAttributedString.Key.foregroundColor: textColor ?? .black
    ]
    self.append(NSMutableAttributedString(string: text, attributes: attrs))
    return self
  }
  
  func underline(_ text: String, fontSize: CGFloat) -> NSMutableAttributedString {
    let attrs: [NSAttributedString.Key: Any] = [
      NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)
    ]
    self.append(NSMutableAttributedString(string: text, attributes: attrs))
    return self
  }
  
  func strikethrough(_ text: String, textColor: UIColor = .black) -> NSMutableAttributedString {
    let attrs: NSMutableAttributedString = NSMutableAttributedString(string: text)
    attrs.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 2,
      range: NSRange(location: 0, length: attrs.length)
    )
    attrs.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: textColor,
      range: NSRange(location: 0, length: attrs.length)
    )
    self.append(attrs)
    return self
  }
}
