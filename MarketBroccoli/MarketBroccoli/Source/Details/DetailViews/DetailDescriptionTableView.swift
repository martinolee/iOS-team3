//
//  DetailDescriptionTableView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailDescriptionTableView: UITableView {
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setupAttr()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - DataSource
extension DetailDescriptionTableView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeue(DetailDescriptionTopTableCell.self)
      return cell
    default:
      fatalError()
    }
  }
}

// MARK: - UI
extension DetailDescriptionTableView {
  private func setupAttr() {
    self.separatorStyle = .none
    self.allowsSelection = false
    self.dataSource = self
    self.register(cell: DetailDescriptionTopTableCell.self)
  }
}
