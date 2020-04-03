//
//  DetailDescriptionTableView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailDescriptionTableView: UITableView {
  let purchaseView = UIView().then {
    $0.backgroundColor = .kurlyMainPurple
    $0.isUserInteractionEnabled = true
  }
  let purchaseLabel = UILabel().then {
    $0.text = "구매하기"
    $0.font = .systemFont(ofSize: 20)
    $0.textColor = .white
  }
  
  override init(frame: CGRect, style: UITableView.Style) {
    super.init(frame: frame, style: style)
    setupAttr()
    setupUI()
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
      let cell = UITableViewCell()
      cell.backgroundColor = .red
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
  }
  
  private func setupUI() {
    purchaseView.addSubview(purchaseLabel)
    self.addSubview(purchaseView)
    
    purchaseLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
    
    purchaseView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.width.equalTo(self)
      $0.height.equalTo(60)
    }
  }
}
