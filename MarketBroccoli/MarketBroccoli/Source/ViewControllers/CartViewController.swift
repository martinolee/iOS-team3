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
  
  private var cart = Cart()
  
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
    
    fetchCart("http://15.164.49.32/kurly/cart/") { response in
      switch response {
      case .success(let data):
        guard let cartData = try? JSONDecoder().decode(Cart.self, from: data) else { return }
        print(cartData.debugDescription)
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
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if cart.isEmpty {
      return 1
    }
    
    return cart.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if cart.isEmpty {
      let cell = tableView.dequeue(EmptyCartTableViewCell.self)
      
      return cell
    }
    
    let product = productDummy[indexPath.row]
    let cell = tableView.dequeue(CartProductTableViewCell.self).then {
      $0.deleagte = self
      
      $0.configure(
        name: product.name,
        productImage: ImageResource(downloadURL: product.imageURL),
        price: product.price,
        discount: product.discount,
        quantity: 4,
        isChecked: true,
        shoppingItemIndexPath: indexPath
      )
    }
    
    return cell
  }
}

// MARK: - Action Handler

extension CartViewController: CartProductTableViewCellDelegate {  
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool, _ shoppingItemIndexPath: IndexPath) {
    setCorrectSelectAllProductCheckBoxStatus()
  }
  
  func productRemoveButtonTouched(_ button: UIButton, _ shoppingItemIndexPath: IndexPath) {
    let removeShoppingItemAlert = UIAlertController(title: nil, message: "삭제하시겠습니까?", preferredStyle: .alert).then {
      $0.addAction(UIAlertAction(title: "취소", style: .cancel))
      $0.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
        self.cartView.reloadCartTableViewData()
      }))
    }
    
    present(removeShoppingItemAlert, animated: true)
  }
  
  func productQuantityStepperValueChanged(_ value: Int, _ shoppingItemIndexPath: IndexPath) {
    cartView.reloadCartTableViewData()
  }
}

extension CartViewController: CartViewDelegate {
  func selectAllProductCheckBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool) {
  }
  
  func removeSelectedProductButton(_ button: UIButton) {
    let message = "선택된 상품을 삭제하시겠습니까?"
    let removeShoppingItemAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert).then {
      $0.addAction(UIAlertAction(title: "취소", style: .cancel))
      $0.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
      }))
    }
    
    present(removeShoppingItemAlert, animated: true)
  }
}

// MARK: - Function

extension CartViewController {
  private func isAllShoppingItemsChecked() -> Bool {
//    var isChecked: Bool?
    
    return true
  }
  
  private func setCorrectSelectAllProductCheckBoxStatus() {
    isAllShoppingItemsChecked()
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

}
