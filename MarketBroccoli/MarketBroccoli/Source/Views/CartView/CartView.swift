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
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool)
  
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
    $0.tableFooterView = cartFooterView
    
    $0.dataSource = self
    
    $0.register(cell: CartProductTableViewCell.self)
  }
  
  private lazy var orderButton = UIButton(type: .system).then {
    $0.backgroundColor = .kurlyPurple
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAttribute()
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
  
  private func setupAttribute() {
    backgroundColor = .kurlyPurple
  }
  
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
    }
    
    orderButton.snp.makeConstraints {
      $0.top.equalTo(cartTableView.snp.bottom)
      $0.leading.trailing.equalTo(cartTableView)
      $0.bottom.equalTo(safeAreaLayoutGuide)
      $0.height.equalTo(60)
    }
  }
  
  private func setupCartFooterViewSize() {
    cartTableView.tableFooterView = cartFooterView.then {
      $0.frame = CGRect(x: 0, y: 0, width: cartTableView.frame.width, height: 200)
      $0.backgroundColor = .white
    }
  }
  
  // MARK: - Element Control
  
  func setSelectAllProductCheckBoxStatus(_ checked: Bool) {
    cartViewHeader.setSelectAllProductCheckBoxStatus(checked)
  }
  
  func reloadCartTableViewData() {
    cartTableView.reloadData()
  }
  
  func setOrderButtonText(totalPrice: Int) {
    let totalPrice = moneyFormatter(won: totalPrice, hasUnit: true)
    let totalPriceText = "주문하기 (\(totalPrice))"
    let buttonAttributedTitle = NSMutableAttributedString(
      string: totalPriceText,
      attributes: [
        .foregroundColor: UIColor.white,
        .font: UIFont.boldSystemFont(ofSize: 17)
      ]
    )

    buttonAttributedTitle.addAttribute(
      .foregroundColor,
      value: UIColor.white.withAlphaComponent(0.5),
      range: NSRange(location: 5, length: totalPriceText.count - 5)
    )
    
    orderButton.setAttributedTitle(buttonAttributedTitle, for: .normal)
  }
}

// MARK: - Action Handler

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

extension CartView: CartViewHeaderDelegate {
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, isChecked: Bool) {
    delegate?.selectAllProductCheckBoxTouched(checkBox, isChecked)
  }
  
  func removeSelectedProductButton(_ button: UIButton) {
    delegate?.removeSelectedProductButton(button)
  }
}

extension CartView: CartFooterViewDataSource {
}
