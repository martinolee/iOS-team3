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
  private var model: MainModel? {
    didSet {
      self.reloadData()
    }
  }
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    
    setupAttr()
    RequestManager.shared.homeRequest(url: .main, method: .get) {
      switch $0 {
      case .success(let data):
        self.model = data
      case .failure(let error):
        print(error)
      }
    }
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
    guard let model = model, !model.recommendation.isEmpty else { return UITableViewCell() }
    switch indexPath.section {
    case 0:
      return tableView.dequeue(HomeBannerTableCell.self)
    case 1:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "이 상품 어때요?", items: model.recommendation)
      return cell
    case 2:
      return tableView.dequeue(HomeEventTableCell.self)
    case 3:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "알뜰 상품 >", items: model.discount)
      return cell
    case 4:
      let cell = tableView.dequeue(HomeMDTableCell.self)
    
      cell.configure(items: model.md.flatMap { $0 })
      return cell
    case 5:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "오늘의 신상품 >", subtitle: "매일 정오, 컬리의 새로운 상품을 만나보세요", items: model.new)
      return cell
    case 6:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "지금 가장 핫한 상품 >", items: model.best)
      cell.backgroundColor = .kurlyGray3
      return cell
    case 7:
      let cell = tableView.dequeue(HomeOfferTableCell.self)
      cell.configure(cellTitle: "컬리의 레시피 >", items: nil)
      return cell
    default:
      return UITableViewCell()
    }
  }
}
