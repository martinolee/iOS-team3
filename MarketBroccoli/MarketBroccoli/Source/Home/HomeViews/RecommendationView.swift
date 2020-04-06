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
  private var offsetArray: [Int: CGFloat] = [:]
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
    self.delegate = self
    self.allowsSelection = false
    self.register(cell: HomeBannerTableCell.self)
    self.register(cell: HomeOfferTableCell.self)
    self.register(cell: HomeEventTableCell.self)
    self.register(cell: HomeMDTableCell.self)
  }
}

// MARK: - Delegate
extension RecommendationView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let tableViewCell = cell as? HomeOfferTableCell else { return }
    tableViewCell.offset = offsetArray[indexPath.section] ?? 0
  }
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard let tableViewCell = cell as? HomeOfferTableCell else { return }
    offsetArray[indexPath.section] = tableViewCell.offset
  }
}

// MARK: - DataSource
extension RecommendationView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    8
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      return tableView.dequeue(HomeBannerTableCell.self)
    case 1:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "이 상품 어때요?")
      return cell
    case 2:
      return tableView.dequeue(HomeEventTableCell.self)
    case 3:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "알뜰 상품 >")
      return cell
    case 4:
      let cell = tableView.dequeue(HomeMDTableCell.self)
      return cell
    case 5:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "오늘의 신상품 >", subtitle: "매일 정오, 컬리의 새로운 상품을 만나보세요")
      return cell
    case 6:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "전자레인지 간편식 >")
      cell.backgroundColor = .kurlyGray3
      return cell
    case 7:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "컬리의 레시피 >")
      return cell
    default:
      return UITableViewCell()
    }
  }
}
