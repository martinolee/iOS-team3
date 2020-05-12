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
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
  
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool)
  
  func removeSelectedProductButton(_ button: UIButton)
}

class CartView: UIView {
  // MARK: - Properties
  
  weak var dataSource: CartViewDataSource?
  
  weak var delegate: CartViewDelegate?
  
  private lazy var activityIndicator = UIActivityIndicatorView(style: .large).then {
    $0.hidesWhenStopped = true
    $0.startAnimating()
    $0.color = .white
  }
  
  private lazy var dimView = UIView().then {
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
  }
  
  private lazy var cartViewHeader = CartViewHeader().then {
    $0.delegate = self
  }
  
  private lazy var cartTableView = UITableView(frame: .zero, style: .grouped).then {
    $0.separatorStyle = .none
    $0.backgroundColor = .kurlyGray3
    $0.tableHeaderView = UIView(frame: .zero)
    $0.tableFooterView = cartFooterView
    $0.tableFooterView?.backgroundColor = .white
    
    $0.dataSource = self
    $0.delegate = self
    
    $0.register(headerFooter: ProductCategoryHeader.self)
    $0.register(cell: CartProductTableViewCell.self)
    $0.register(cell: EmptyCartTableViewCell.self)
  }
  
  private lazy var cartFooterView = CartFooterView()
  
  private lazy var orderButton = UIButton(type: .system).then {
    $0.backgroundColor = .kurlyMainPurple
  }
  
  // MARK: - Initialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAttribute()
    addAllView()
    setupCartTableViewAutoLayout()
    setOrderButtonText(totalPrice: 0)
    setCartTableHeaderSize()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    setCartTableFooterSize()
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    backgroundColor = .kurlyMainPurple
  }
  
  private func addAllView() {
    self.addSubviews([
      dimView,
      cartViewHeader,
      cartTableView,
      orderButton
    ])
    
    dimView.addSubview(activityIndicator)
  }
  
  private func setupCartTableViewAutoLayout() {
    let safeArea = safeAreaLayoutGuide
    
    dimView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    activityIndicator.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    cartViewHeader.snp.makeConstraints {
      $0.top.equalTo(safeArea)
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
      $0.bottom.equalTo(safeArea)
      $0.height.equalTo(60)
    }
    
    self.bringSubviewToFront(dimView)
  }
  
  private func setCartTableHeaderSize() {
    guard let header = cartTableView.tableHeaderView else { return }
    
    header.frame = .zero
    
    cartTableView.tableHeaderView = header
  }
  
  private func setCartTableFooterSize() {
    guard let footer = cartTableView.tableFooterView else { return }
    
    footer.frame = CGRect(x: 0, y: 0, width: cartTableView.frame.width, height: 200)
    
    cartTableView.tableFooterView = footer
  }
  
  // MARK: - Element Control
  
  func configureHeader(selectedProductCount: Int, totalProductsCount: Int) {
    cartViewHeader.configure(
      selectedProductCount: selectedProductCount,
      totalProductsCount: totalProductsCount
    )
  }
  
  func configureFooter(
    totalProductPrice: Int, discountProductPrice: Int, shippingFee: Int, expectedAmountPayment: Int
  ) {
    cartFooterView.configure(
      totalProductPrice: totalProductPrice,
      discountProductPrice: discountProductPrice,
      shippingFee: shippingFee,
      expectedAmountPayment: expectedAmountPayment
    )
  }
  
  func setSelectAllProductCheckBoxStatus(_ checked: Bool) {
    cartViewHeader.setSelectAllProductCheckBoxStatus(checked)
  }
  
  func reloadCartTableViewData() {
    cartTableView.reloadData()
  }
  
  func hideAllFooterSubviews(_ hidden: Bool) {
    cartFooterView.hideAllSubviews(hidden)
  }
  
  func removeDimView() {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
    
    dimView.removeFromSuperview()
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

extension CartView: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    delegate?.tableView(tableView, viewForHeaderInSection: section)
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    delegate?.tableView(tableView, heightForHeaderInSection: section) ?? 0
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    delegate?.tableView(tableView, viewForFooterInSection: section)
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    delegate?.tableView(tableView, heightForFooterInSection: section) ?? 0
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
