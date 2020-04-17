//
//  AddProductCartView.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol AddProductCartViewDataSource: class {
  func numberOfSections(in tableView: UITableView) -> Int
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol AddProductCartViewDelegate: class {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
}

class AddProductCartView: UIView {
  // MARK: - Properteis
  
  weak var dataSource: AddProductCartViewDataSource?
  
  weak var delegate: AddProductCartViewDelegate?
  
  private lazy var productTableView = UITableView().then {
    $0.register(cell: SelectingProductCell.self)
    
    $0.dataSource = self
    $0.delegate = self
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AddProductCartView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    dataSource?.numberOfSections(in: tableView) ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    dataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    dataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
  }
}

extension AddProductCartView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    delegate?.tableView(tableView, viewForHeaderInSection: section)
  }
}
