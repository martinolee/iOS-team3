//
//  PopularSearchWordCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PopularSearchWordCell: UITableViewCell {
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupAttribute()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    textLabel?.textColor = .kurlyMainPurple
  }
}
