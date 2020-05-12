//
//  ShowAllView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/16.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ShowAllView: UIView {
  let collectionView = NewProduct(frame: .zero, collectionViewLayout: CustomCollectionViewFlowLayout())
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ShowAllView {
  private func setupUI() {
    self.addSubviews([collectionView])
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
