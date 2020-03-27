//
//  CustomCollectionViewFlowLayout.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
  override init() {
    super.init()
    self.scrollDirection = .horizontal
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
    let parent = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
    
    let itemSpace = itemSize.width + minimumInteritemSpacing
    var currentItemIdx = round(collectionView.contentOffset.x / itemSpace)

    if velocity.x > 0 { currentItemIdx += 1 }
    else if velocity.x < 0 { currentItemIdx -= 1 }
    
    return CGPoint(x: currentItemIdx * itemSpace,
                   y: parent.y)
  }
}
