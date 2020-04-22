//
//  UIViewExtension.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIView {
  var viewController: UIViewController? {
    if let vc = self.next as? UIViewController {
      return vc
    } else if let superView = self.superview {
      return superView.viewController
    } else {
      return nil
    }
  }

func shadow() {
  self.layer.shadowRadius = 5.0
  self.layer.shadowOpacity = 0.3
  self.layer.shadowOffset = .zero
  self.layer.shadowColor = UIColor.darkGray.cgColor
}

func addSubviews(_ views: [UIView]) {
  views.forEach { addSubview($0) }
}
}
