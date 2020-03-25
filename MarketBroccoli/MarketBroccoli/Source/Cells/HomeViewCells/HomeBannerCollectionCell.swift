//
//  BannerCollectionCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class BannerCollectionCell: UICollectionViewCell {
  let imageView = UIImageView().then {
    $0.contentMode = .scaleToFill
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

//MARk: - ACTIONS
extension BannerCollectionCell {
  func configure(image: String) {
    imageView.image = UIImage(named: image) ?? UIImage(named: "cloud")
  }
}

// MARK: - UI
extension BannerCollectionCell {
  private func setupUI() {
    self.contentView.addSubview(imageView)
    imageView.snp.makeConstraints {
      $0.top.leading.bottom.trailing.equalTo(self.contentView)
    }
  }
}
