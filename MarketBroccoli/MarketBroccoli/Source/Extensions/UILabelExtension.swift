//
//  UILabelExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UILabel {
  func getWidth() -> CGFloat? {
    if let title = self.text, let font = self.font {
      let attr = [NSAttributedString.Key.font: font]
      return (title as NSString).size(withAttributes: attr).width
    }
    return nil
  }
}
