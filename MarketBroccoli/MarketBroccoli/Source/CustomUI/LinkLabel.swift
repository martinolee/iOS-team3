//
//  LinkLabel.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/22.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class LinkLabel: UILabel {
  var link = ""
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
