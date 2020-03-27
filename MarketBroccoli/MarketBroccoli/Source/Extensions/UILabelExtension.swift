//
//  UILabelExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UILabel {
  func getSize() -> CGSize? {
    if let title = self.text, let font = self.font {
      let attr = [NSAttributedString.Key.font: font]
      return (title as NSString).size(withAttributes: attr)
    }
    return nil
  }
  
  func getWidth() -> CGFloat? {
    if let title = self.text, let font = self.font {
      let attr = [NSAttributedString.Key.font: font]
      return (title as NSString).size(withAttributes: attr).width
    }
    return nil
  }
  
  func strikethrough() {
    guard let text = self.text else { return }
    let attribute: NSMutableAttributedString = NSMutableAttributedString(string: text)
    attribute.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 2,
      range: NSRange(location: 0, length: attribute.length)
    )
    self.attributedText = attribute
  }
}
