//
//  CartView.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import Then
import SnapKit
import UIKit

protocol CartViewDelegate: class {
  func numberOfSections(in tableView: UITableView) -> Int
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  
  func selectingOptionButtonTouched(_ button: UIButton)
  
  func productRemoveButtonTouched(_ button: UIButton)
  
  func subtractionButtonTouched(_ button: UIButton)
  
  func additionButtonTouched(_ button: UIButton)
}

class CartView: UIView {
  // MARK: - Properties
  
  weak var delegate: CartViewDelegate?
  
  private lazy var cartTableView = UITableView().then {
    $0.separatorStyle = .none
    
    $0.dataSource = self
    
    $0.register(cell: CartProductTableViewCell.self)
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllView()
    setupCartTableViewAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubview(cartTableView)
  }
  
  private func setupCartTableViewAutoLayout() {
    cartTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  // MARK: - Action Handler
}

extension CartView: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    delegate?.numberOfSections(in: tableView) ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    delegate?.tableView(tableView, numberOfRowsInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    delegate?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
  }
}

extension CartView: CartProductTableViewCellDelegate {
  func selectingOptionButtonTouched(_ button: UIButton) {
    delegate?.selectingOptionButtonTouched(button)
  }
  
  func productRemoveButtonTouched(_ button: UIButton) {
    delegate?.productRemoveButtonTouched(button)
  }
  
  func subtractionButtonTouched(_ button: UIButton) {
    delegate?.subtractionButtonTouched(button)
  }
  
  func additionButtonTouched(_ button: UIButton) {
    delegate?.additionButtonTouched(button)
  }
}
