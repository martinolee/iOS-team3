//
//  RecommendationView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

// MARK: - 컬리추천
class RecommendationView: UITableView {
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setupAttr()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension RecommendationView {
  private func setupAttr() {
    self.separatorStyle = .none
    self.dataSource = self
    self.register(cell: HomeImageTableCell.self)
  }
}

// MARK: - TableViewDataSource, TableViewDelegate
extension RecommendationView: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return tableView.dequeue(HomeImageTableCell.self)
    default:
      return UITableViewCell()
    }
  }
}
