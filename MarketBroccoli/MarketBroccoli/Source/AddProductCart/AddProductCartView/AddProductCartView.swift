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
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
  
  func addProductInCartButtonTouched(_ button: UIButton)
}

class AddProductCartView: UIView {
  // MARK: - Properteis
  
  weak var dataSource: AddProductCartViewDataSource?
  
  weak var delegate: AddProductCartViewDelegate?
  
  private lazy var activityIndicator = UIActivityIndicatorView(style: .large).then {
    $0.hidesWhenStopped = true
    $0.startAnimating()
    $0.color = .white
  }
  
  private lazy var dimView = UIView().then {
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.6)
  }
  
  private lazy var productTableView = UITableView(frame: .zero, style: .grouped).then {
    $0.separatorStyle = .none
    $0.backgroundColor = .kurlyGray3
    $0.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 8))
    
    $0.register(headerFooter: ProductCategoryHeader.self)
    $0.register(cell: SelectingProductCell.self)
    $0.register(headerFooter: SelectingProductFooter.self)
    
    $0.dataSource = self
    $0.delegate = self
  }
  
  private lazy var addProductInCartButton = UIButton(type: .system).then {
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .kurlyMainPurple
    
    $0.setTitle("장바구니에 담기", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
    
    $0.addTarget(self, action: #selector(addProductInCartButtonTouched(_:)), for: .touchUpInside)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAttribute()
    addAllViews()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .kurlyMainPurple
  }
  
  private func addAllViews() {
    self.addSubviews([
      dimView,
      productTableView,
      addProductInCartButton
    ])
    
    dimView.addSubview(activityIndicator)
  }
  
  private func setupAutoLayout() {
    dimView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    activityIndicator.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
    
    productTableView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.bottom.equalTo(addProductInCartButton.snp.top)
    }
    
    addProductInCartButton.snp.makeConstraints {
      $0.leading.bottom.trailing.equalTo(safeAreaLayoutGuide)
      $0.height.equalTo(60)
    }
    
    self.bringSubviewToFront(dimView)
  }
}

// MARK: - Action Handler

extension AddProductCartView {
  @objc
  private func addProductInCartButtonTouched(_ button: UIButton) {
    delegate?.addProductInCartButtonTouched(button)
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

// MARK: - Element Control

extension AddProductCartView {
  func removeDimView() {
    activityIndicator.stopAnimating()
    activityIndicator.removeFromSuperview()
    
    dimView.removeFromSuperview()
  }
  
  func reloadProductTableViewData() {
    productTableView.reloadData()
  }
}
