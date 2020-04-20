//
//  UIViewExtension.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIView {
  var parentVC: UIViewController? {
    var parent: UIResponder? = self
    while parent != nil {
      parent = parent?.next
      if let viewController = parent as? UIViewController {
        return viewController
      }
    }
    return nil
  }
  var viewController: UIViewController? {
    print("call")
    if let vc = self.next as? UIViewController {
      print(1)
      return vc
    } else if let superView = self.superview {
      print(2)
      return superView.viewController
    } else {
      print(3)
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
