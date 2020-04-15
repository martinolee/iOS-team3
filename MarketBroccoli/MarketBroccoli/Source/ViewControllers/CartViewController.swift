//
//  CartViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import Alamofire
import Kingfisher
import UIKit

class CartViewController: UIViewController {
  // MARK: - Properties
  
  private var cart: Cart? {
    didSet {
      cartView.reloadCartTableViewData()
    }
  }
  
  private lazy var cartView = CartView().then {
    $0.dataSource = self
    $0.delegate = self
  }

  // MARK: - Life Cycle

  override func loadView() {
    view = cartView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupAttribute()
    setupLeftBarButtonItem()
    setCorrectSelectAllProductCheckBoxStatus()
    
    fetchCart("http://15.164.49.32/kurly/cart/") { [weak self] response in
      switch response {
      case .success(let data):
        guard let backendCart = try? JSONDecoder().decode(BackendCart.self, from: data) else { return }
        self?.cart = convertToCart(from: backendCart)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
  
  // MARK: - Setup Attribute
  
  private func setupAttribute() {
    title = "장바구니"
    
    navigationController?.do({
      $0.navigationBar.barTintColor = .white
      $0.navigationBar.isTranslucent = false
      $0.navigationBar.barStyle = .black
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    })
  }
  
  @objc
  private func closeCart() {
    dismiss(animated: true)
  }
  
  private func setupLeftBarButtonItem() {
    let closeCartbutton = UIButton(type: .system).then {
      $0.tintColor = .black
      $0.setImage(UIImage(systemName: "xmark"), for: .normal)
      
      $0.addTarget(self, action: #selector(closeCart), for: .touchUpInside)
    }
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeCartbutton)
  }
}

extension CartViewController: CartViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    guard let cart = cart, !cart.isEmpty else { return 1 }
    
    return cart.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let cart = cart, !cart.isEmpty else { return 1 }
    
    return cart[section].wishProducts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cart = cart, !cart.isEmpty else { return tableView.dequeue(EmptyCartTableViewCell.self) }
    
    let wishProduct = cart[indexPath.section].wishProducts[indexPath.row]
    let cell = tableView.dequeue(CartProductTableViewCell.self).then {
      $0.deleagte = self
      
      $0.configure(
        name: wishProduct.product.name,
        imageURL: wishProduct.product.imageURL,
        price: wishProduct.product.price,
        discount: cart[indexPath.section].discountRate,
        quantity: wishProduct.quantity,
        isChecked: wishProduct.isChecked,
        shoppingItemIndexPath: indexPath
      )
    }
    
    return cell
  }
}

// MARK: - Action Handler

extension CartViewController: CartProductTableViewCellDelegate {  
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool, _ shoppingItemIndexPath: IndexPath) {
    guard var cart = cart else { return }
    
    cart[shoppingItemIndexPath.section].wishProducts[shoppingItemIndexPath.row].isChecked = isChecked

    self.cart = cart
    setCorrectSelectAllProductCheckBoxStatus()
  }
  
  func productRemoveButtonTouched(_ button: UIButton, _ shoppingItemIndexPath: IndexPath) {
    let removeShoppingItemAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: .alert).then {
      $0.addAction(UIAlertAction(title: "취소", style: .cancel))
      $0.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
        guard let self = self, var cart = self.cart else { return }
        cart[shoppingItemIndexPath.section].wishProducts.remove(at: shoppingItemIndexPath.row)
        
        self.cart = cart
      }))
    }
    
    present(removeShoppingItemAlert, animated: true)
  }
  
  func productQuantityStepperValueChanged(_ value: Int, _ shoppingItemIndexPath: IndexPath) {
    guard var cart = cart else { return }
    let product: UpdatedProduct
    cart[shoppingItemIndexPath.section].wishProducts[shoppingItemIndexPath.row].quantity = value
    
    if cart[shoppingItemIndexPath.section].name != nil {
      product = UpdatedProduct(
        product: cart[shoppingItemIndexPath.section].id,
        option: cart[shoppingItemIndexPath.section].wishProducts[shoppingItemIndexPath.row].product.id,
        quantity: cart[shoppingItemIndexPath.section].wishProducts[shoppingItemIndexPath.row].quantity
      )
    } else {
      product = UpdatedProduct(
        product: cart[shoppingItemIndexPath.section].headID,
        option: nil,
        quantity: cart[shoppingItemIndexPath.section].wishProducts[shoppingItemIndexPath.row].quantity
      )
    }
    
    patchProductQuntity(
      id: cart[shoppingItemIndexPath.section].headID,
      product: product
    ) { response in
      switch response {
      case .success(let data):
        guard let product = try? JSONDecoder().decode(BackendCartElement.self, from: data) else { return }
        
        print(product)
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
    
    self.cart = cart
  }
}

extension CartViewController: CartViewDelegate {
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool) {
    guard var cart = cart else { return }
    
    for cartIndex in cart.indices {
      for productIndex in cart[cartIndex].wishProducts.indices {
        cart[cartIndex].wishProducts[productIndex].isChecked = isChecked
      }
    }
    
    self.cart = cart
  }
  
  func removeSelectedProductButton(_ button: UIButton) {
    let message = "선택된 상품을 삭제하시겠습니까?"
    let removeShoppingItemAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert).then {
      $0.addAction(UIAlertAction(title: "취소", style: .cancel))
      $0.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { [weak self] _ in
        guard let self = self, var cart = self.cart else { return }
        for index in cart.indices {
          cart[index].wishProducts = cart[index].wishProducts.filter { !$0.isChecked }
        }
        self.cart = cart.filter { !$0.wishProducts.isEmpty }
      }))
    }
    
    present(removeShoppingItemAlert, animated: true)
  }
}

// MARK: - Function

extension CartViewController {
  private var isAllShoppingItemsChecked: Bool {
    guard let cart = cart else { return true }
    
    for cart in cart {
      for product in cart.wishProducts where !product.isChecked {
        return product.isChecked
      }
    }
    
    return true
  }
  
  private func setCorrectSelectAllProductCheckBoxStatus() {
    isAllShoppingItemsChecked
      ? cartView.setSelectAllProductCheckBoxStatus(true)
      : cartView.setSelectAllProductCheckBoxStatus(false)
  }
}

extension CartViewController {
  private func fetchCart(_ url: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(url)
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  private func patchProductQuntity(id: Int, product: UpdatedProduct,
                                   completionHandler: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      "http://15.164.49.32/kurly/cart/\(id)/",
      method: .patch,
      parameters: product,
      encoder: JSONParameterEncoder.default,
      headers: ["Content-Type": "application/json"]
      )
      .validate()
      .responseData { response in
        switch response.result {
        case .success(let data):
          completionHandler(.success(data))
        case .failure(let error):
          completionHandler(.failure(error))
        }
    }
  }
  
  private func removeProduct(id: Int) {
    AF.request(
      "http://15.164.49.32/kurly/cart/\(id)/",
      method: .delete
    )
  }
}
