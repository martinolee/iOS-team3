//
//  AddProductCartViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class AddProductCartViewController: UIViewController {
  // MARK: - Properties
   
  private lazy var addProductCartView = AddProductCartView().then {
    $0.dataSource = self
    $0.delegate = self
  }
//  http://15.164.49.32/kurly/product/\(id)/option/
  
  private lazy var dummy: ProductCategory? = ProductCategory(
    headID: 0,
    id: 567,
    name: "[유가원] 유기농 크런치 씨리얼 4종",
    discountRate: 0.5,
    wishProducts: [
      WishProduct(
        product: Product(
          id: 378,
          name: "[유가원] 유기농 크런치트로피칼후르츠 씨리얼 400g",
          price: 12900,
          imageURL: ""
        ),
        quantity: 0,
        isChecked: true
      ),
      WishProduct(
        product: Product(
          id: 378,
          name: "[유가원] 유기농 크런치애플시나몬 씨리얼 400g",
          price: 12500,
          imageURL: ""
        ),
        quantity: 0,
        isChecked: true
      ),
      WishProduct(
        product: Product(
          id: 378,
          name: "[유가원] 유기농 초코크런치 씨리얼 400g",
          price: 12900,
          imageURL: ""
        ),
        quantity: 0,
        isChecked: true
      ),
      WishProduct(
        product: Product(
          id: 378,
          name: "[유가원] 유기농 프로틴리치그래놀라 씨리얼 400g",
          price: 12900,
          imageURL: ""
        ),
        quantity: 0,
        isChecked: true
      )
    ]
  )
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = addProductCartView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupNavigation()
  }
  
  // MARK: - Setup Navigation
  
  private func setupNavigation() {
    title = "상품 선택"
    navigationController?.do({
      $0.navigationBar.barTintColor = .white
      $0.navigationBar.isTranslucent = false
      $0.navigationBar.barStyle = .black
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    })
    
    let closeCartbutton = UIButton(type: .system).then {
      $0.tintColor = .black
      $0.setImage(UIImage(systemName: "xmark"), for: .normal)
      
      $0.addTarget(self, action: #selector(closeCart), for: .touchUpInside)
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeCartbutton)
  }
  
  @objc
  private func closeCart() {
    dismiss(animated: true)
  }
}

extension AddProductCartViewController: AddProductCartViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let dummy = dummy else { return 0 }
    
    return dummy.wishProducts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let dummy = dummy else { return UITableViewCell() }
    
    let product = dummy.wishProducts[indexPath.row]
    let cell = tableView.dequeue(SelectingProductCell.self).then {
      $0.delegate = self
      
      $0.configure(
        name: product.product.name,
        price: product.product.price,
        discount: dummy.discountRate,
        quantity: product.quantity,
        productIndexPath: indexPath
      )
    }
    
    return cell
  }
}

// MARK: - Action Handler

extension AddProductCartViewController: AddProductCartViewDelegate {
  func addProductInCartButtonTouched(_ button: UIButton) {
    print("addProductInCartButtonTouched(_ button: UIButton)")
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let dummy = dummy, !dummy.wishProducts.isEmpty, let name = dummy.name else { return nil }
    
    return tableView.dequeue(ProductCategoryHeader.self).then {
      $0.configure(productCategoryName: name)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let dummy = dummy, !dummy.wishProducts.isEmpty, dummy.name != nil else { return 0 }
    
    return 38
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    guard let dummy = dummy else { return nil }
    var totalPrice = 0
    
    for product in dummy.wishProducts {
      totalPrice += product.product.price * product.quantity
    }
    
    return tableView.dequeue(SelectingProductFooter.self).then {
      $0.configure(totalPrice: totalPrice)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    guard let dummy = dummy, !dummy.wishProducts.isEmpty, dummy.name != nil else { return 0 }
    
    return 38
  }
}

extension AddProductCartViewController: SelectingProductCellDelegate {
  func productQuantityStepperValueChanged(_ value: Int, _ productIndexPath: IndexPath) {
    print("productQuantityStepperValueChanged")
    dummy?.wishProducts[productIndexPath.row].quantity = value
    
    addProductCartView.reloadProductTableViewData()
  }
}
