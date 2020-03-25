//
//  HomeProductCollectionView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeProductCollectionView: UICollectionView {
  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    self.showsHorizontalScrollIndicator = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - CustomLayout Func
extension HomeProductCollectionView {
  func productLayout() {
    guard let layout = self.collectionViewLayout as? CustomCollectionViewFlowLayout else { return }
    let margin: CGFloat = 10
    let itemCount: CGFloat = 2.3
    let contentSize: CGFloat = (self.frame.width - (margin * 2) - (10 * (itemCount - 1))).rounded(.down)
    layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    layout.itemSize = CGSize(width: contentSize, height: 160)
  }
}
