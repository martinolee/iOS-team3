//
//  ShowAllProductViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ShowAllProductViewController: UIViewController {
  override func loadView() {
    view = ShowAllView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

extension ShowAllProductViewController {
  private func setupUI() {
    
  }
}

class ShowAllView: UIView {
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    $0.backgroundColor = .kurlyGray3
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
