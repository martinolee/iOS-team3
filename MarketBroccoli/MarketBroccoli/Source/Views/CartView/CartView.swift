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

protocol CartViewDataSource: class {
  func numberOfSections(in tableView: UITableView) -> Int
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}

protocol CartViewDelegate: class {
  func selectingOptionButtonTouched(_ button: UIButton)
  
  func productRemoveButtonTouched(_ button: UIButton)
  
  func subtractionButtonTouched(_ button: UIButton, _ valueLabel: UILabel)
  
  func additionButtonTouched(_ button: UIButton, _ valueLabel: UILabel)
  
  func selectAllProductButtonTouched(_ button: UIButton)
  
  func removeSelectedProductButton(_ button: UIButton)
}

class CartView: UIView {
  // MARK: - Properties
  
  weak var dataSource: CartViewDataSource?
  
  weak var delegate: CartViewDelegate?
  
  private lazy var cartViewHeader = CartViewHeader().then {
    $0.delegate = self
  }
  
  private lazy var cartFooterView = CartFooterView().then {
    $0.dataSource = self
  }
  
  private lazy var cartTableView = UITableView().then {
    $0.separatorStyle = .none
    $0.backgroundColor = .lightGray
    $0.dataSource = self
    
    $0.register(cell: CartProductTableViewCell.self)
  }
  
  private lazy var orderButton = UIButton(type: .system).then {
    $0.backgroundColor = .kurlyPurple
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
  
  override func layoutSubviews() {
    setupCartFooterViewSize()
  }
  
  // MARK: - Setup UI
  
  private func addAllView() {
    self.addSubviews([
      cartViewHeader,
      cartTableView,
      orderButton
    ])
  }
  
  private func setupCartTableViewAutoLayout() {
    cartViewHeader.snp.makeConstraints {
      $0.top.equalTo(safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.width.equalTo(cartTableView)
      $0.height.equalTo(50)
    }
    
    cartTableView.snp.makeConstraints {
      $0.top.equalTo(cartViewHeader.snp.bottom)
      $0.leading.trailing.equalTo(cartViewHeader)
      $0.bottom.equalToSuperview()
    }
    
    cartTableView.snp.makeConstraints {
      $0.top.equalTo(cartTableView.snp.bottom)
      $0.leading.trailing.equalTo(cartTableView)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setupCartFooterViewSize() {
    cartTableView.tableFooterView = cartFooterView.then({
      $0.frame = CGRect(x: 0, y: 0, width: cartTableView.frame.width, height: 300)
      $0.backgroundColor = .white
    })
  }
  
  // MARK: - Action Handler
}

extension CartView: UITableViewDataSource {
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

extension CartView: CartProductTableViewCellDelegate {
  func selectingOptionButtonTouched(_ button: UIButton) {
    delegate?.selectingOptionButtonTouched(button)
  }
  
  func productRemoveButtonTouched(_ button: UIButton) {
    delegate?.productRemoveButtonTouched(button)
  }
  
  func subtractionButtonTouched(_ button: UIButton, _ valueLabel: UILabel) {
    delegate?.subtractionButtonTouched(button, valueLabel)
  }
  
  func additionButtonTouched(_ button: UIButton, _ valueLabel: UILabel) {
    delegate?.additionButtonTouched(button, valueLabel)
  }
}

extension CartView: CartViewHeaderDelegate {
  func selectAllProductButtonTouched(_ button: UIButton) {
    delegate?.selectAllProductButtonTouched(button)
  }
  
  func removeSelectedProductButton(_ button: UIButton) {
    delegate?.removeSelectedProductButton(button)
  }
}

extension CartView: CartFooterViewDataSource {
}
