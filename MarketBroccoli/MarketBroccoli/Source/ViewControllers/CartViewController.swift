//
//  CartViewController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
  // MARK: - Properties
  
  private lazy var cartView = CartView().then {
    $0.delegate = self
  }

  // MARK: - Life Cycle

  override func loadView() {
    view = cartView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension CartViewController: CartViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(CartProductTableViewCell.self).then {
      $0.deleagte = self
      $0.configure(name: "[선물세트][안국건강] 안심도 종합건강 4구세트", originalPrice: 190000, currentPrice: 95000)
    }
    
    return cell
  }
}

extension CartViewController: CartProductTableViewCellDelegate {
  func whenSelectingOptionButtonDidTouchUpInside(_ button: UIButton) {
    print("whenSelectingOptionButtonDidTouchUpInside")
  }
  
  func whenProductRemoveButtonDidTouchUpInside(_ button: UIButton) {
     print("whenProductRemoveButtonDidTouchUpInside")
  }
  
  func whenSubtractionButtonDidTouchUpInside(_ button: UIButton) {
    print("whenSubtractionButtonDidTouchUpInside")
  }
  
  func whenAdditionButtonDidTouchUpInside(_ button: UIButton) {
    print("whenAdditionButtonDidTouchUpInside")
  }
}
