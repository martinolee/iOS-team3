//
//  NewProductView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class NewProduct: UICollectionView {
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
    let margin: CGFloat = 20
    let itemCount: CGFloat = 2
    let width: CGFloat = self.frame.width
    layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
    let contentWidth: CGFloat = width - (margin * 2) - (10 * (itemCount - 1))
    let itemWidth: CGFloat = (contentWidth / itemCount).rounded(.down)
    layout.itemSize = CGSize(width: itemWidth, height: 200)
  }
}
