//
//  RecommendationCollectionViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class RecommendationCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  private let imageView = UIImageView().then {
    $0.backgroundColor = .systemTeal
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
  }
  private let titleLabel = UILabel().then {
//    $0.textColor = .kurlyGray1
    $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    $0.backgroundColor = .systemPink
  }
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func setupUI() {
    [imageView, titleLabel].forEach {
      self.addSubview($0)
    }
  }
  private func setupLayout() {
    imageView.snp.makeConstraints { (make) -> Void in
      make.leading.equalToSuperview()
      make.top.equalToSuperview()
//      make.width.equalTo(100)
//      make.height.equalTo(100)
    }
    titleLabel.snp.makeConstraints { (make) -> Void in
      make.leading.trailing.bottom.equalToSuperview()
      make.top.equalTo(imageView.snp.top)
    }
  }
  func configure(image: UIImage?, title: String) {
    imageView.image = image
    titleLabel.text = title
  }
}
