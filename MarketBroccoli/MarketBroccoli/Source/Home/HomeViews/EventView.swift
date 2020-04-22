//
//  EventView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class EventView: UITableView {
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension EventView {
  private func setupAttr() {
    self.backgroundColor = .white
//    self.register(cell: <#T##Cell.Type#>)
  }
  private func setupUI() {
    
  }
}
