//
//  UIImageViewExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIImageView {
  func setImage(urlString: String) {
    let url = URL(string: urlString)
    self.kf.setImage(with: url)
  }
}
