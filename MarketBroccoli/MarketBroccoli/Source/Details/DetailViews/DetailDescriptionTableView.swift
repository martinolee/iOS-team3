//
//  DetailDescriptionTableView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailDescriptionTableView: UITableView {
  private var parentViewController: UIViewController? {
    willSet {
      guard let dataSource = newValue as? UITableViewDataSource else { return }
      self.dataSource = dataSource
    }
  }
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setupAttr()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    guard let VC = self.viewController else { return }
    parentViewController = VC
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension DetailDescriptionTableView {
  private func setupAttr() {
    self.separatorStyle = .none
    self.allowsSelection = false
    self.register(cell: DetailDescriptionTopTableCell.self)
    self.register(cell: DetailDescriptionBottomTableCell.self)
  }
}
