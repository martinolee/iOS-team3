//
//  AddProductCartViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Alamofire

class AddProductCartViewController: UIViewController {
  // MARK: - Properties
  
  private let cartManager = CartManager.shared
  
  private var productModel: ProductModel? {
    didSet {
      guard let productModel = productModel else { return }
      
      productList = convertProductList(from: productModel)
    }
  }
  
  private var productList: ProductList? {
    didSet {
      addProductCartView.reloadProductTableViewData()
    }
  }
  
  private lazy var addProductCartView = AddProductCartView().then {
    $0.dataSource = self
    $0.delegate = self
  }
  
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
    guard let productList = productList else { return 0 }
    
    return productList.productOptions.count == 0 ? 1 : productList.productOptions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let productList = productList else { return UITableViewCell() }
    let product = productList.productOptions[indexPath.row]
    
    let cell = tableView.dequeue(SelectingProductCell.self).then {
      $0.delegate = self
      
      $0.configure(
        name: product.product.name,
        price: product.product.price,
        discount: productList.discountRate,
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
      guard let productList = productList else { return }
      let selectedProducts = productList.productOptions.filter({ $0.quantity > 0 })
      let productID = productList.id
      
      guard !selectedProducts.isEmpty else {
        KurlyNotification.shared.notification(text: "수량은 반드시 1 이상이여야 합니다.")
        
        return
      }
      
      if !productList.productOptions.isEmpty {
        for selectedProduct in selectedProducts {
          let optionID = selectedProduct.product.id
          let quantity = selectedProduct.quantity
          let selectedProduct = UpdatedProduct(product: productID, option: optionID, quantity: quantity)
          
          cartManager.addProductIntoCart(selectedProduct) { response in
            switch response {
            case .success(let data):
              print(data)
            case .failure(let error):
              print(error.localizedDescription)
            }
          }
        }
      } else {
        guard let selectedProduct = selectedProducts.first else { return }
        let quantity = selectedProduct.quantity
        let product = UpdatedProduct(product: productID, option: nil, quantity: quantity)
        
        cartManager.addProductIntoCart(product) { response in
          switch response {
          case .success(let data):
            print(data)
          case .failure(let error):
            print(error.localizedDescription)
          }
        }
      }
      
      dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      guard let productList = productList else { return nil }
      
      return tableView.dequeue(ProductCategoryHeader.self).then {
        $0.configure(productCategoryName: productList.name)
      }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      guard productList != nil else { return 0 }
      
      return 38
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
      guard let productList = productList else { return nil }
      var totalPrice = 0
      
      for product in productList.productOptions {
        totalPrice += product.product.price * product.quantity
      }
      
      return tableView.dequeue(SelectingProductFooter.self).then {
        $0.configure(totalPrice: totalPrice)
      }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      38
    }
}

extension AddProductCartViewController: SelectingProductCellDelegate {
  func productQuantityStepperValueChanged(_ value: Int, _ productIndexPath: IndexPath) {
    guard var productList = productList else { return }
    productList.productOptions[productIndexPath.row].quantity = value
    
    self.productList = productList
  }
}

extension AddProductCartViewController {
  private func convertProductList(from productModel: ProductModel) -> ProductList {
    let id = productModel.id
    let name = productModel.name
    let price = productModel.price
    let discountRate = productModel.discountRate
    var productOptions = [SelectableProduct]()
    let quantity = productModel.options.count == 0 ? 1 : 0
    
    if productOptions.isEmpty {
      return ProductList(
        id: id,
        name: name,
        discountRate: discountRate,
        productOptions: [
          SelectableProduct(
            product: ProductOption(
              id: id,
              name: name,
              price: price
            ),
            quantity: quantity
          )
        ]
      )
    } else {
      for option in productModel.options {
        if let option = option {
          let id = option.pk
          let name = option.name
          let price = option.price
          productOptions.append(
            SelectableProduct(
              product: ProductOption(
                id: id,
                name: name,
                price: price
              ),
              quantity: quantity
            )
          )
        }
      }
    }
    
    return ProductList(id: id, name: name, discountRate: discountRate, productOptions: productOptions)
  }
}
