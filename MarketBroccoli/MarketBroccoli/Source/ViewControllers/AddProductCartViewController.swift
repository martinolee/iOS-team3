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
  
  // MARK: - Life Cycle
  
  override func loadView() {
    view = addProductCartView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension AddProductCartViewController: AddProductCartViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(SelectingProductCell.self).then {
      $0.configure(name: <#T##String#>, price: <#T##Int#>, discount: <#T##Double#>, shoppingItemIndexPath: indexPath)
    }
    
    return cell
  }
}

extension AddProductCartViewController: AddProductCartViewDelegate {
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    nil
  }
}
