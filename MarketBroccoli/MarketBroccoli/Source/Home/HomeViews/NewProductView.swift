//
//  NewProductView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class NewProduct: UICollectionView {
  var collectionName = ""
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    self.backgroundColor = .clear
    self.decelerationRate = UIScrollView.DecelerationRate.fast
    self.showsHorizontalScrollIndicator = false
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension NewProduct {
  private func setupLayout() {
    guard let layout = self.collectionViewLayout as? CustomCollectionViewFlowLayout else { return }
    layout.scrollDirection = .vertical
  }
}
