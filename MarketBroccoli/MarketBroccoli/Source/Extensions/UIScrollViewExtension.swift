//
//  UIScrollViewExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/31.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIScrollView {
  var minContentOffset: CGPoint {
    return CGPoint(
      x: -contentInset.left,
      y: -contentInset.top)
  }

  var maxContentOffset: CGPoint {
    return CGPoint(
      x: contentSize.width - bounds.width + contentInset.right,
      y: contentSize.height - bounds.height + contentInset.bottom)
  }
}
