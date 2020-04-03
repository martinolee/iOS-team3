//
//  MDCategoryCollectionCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class MDCategoryCollectionCell: UICollectionViewCell {
  let titleLabel = UILabel().then {
    $0.textColor = .gray
    $0.isUserInteractionEnabled = true
  }
  private var index = 0
  weak var delegate: MDCategoryTouchProtocol?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    titleLabel.textColor = .gray
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension MDCategoryCollectionCell {
  @objc private func cellTouched(_ sender: UITapGestureRecognizer) {
    guard let delegate = delegate else { return }
    delegate.cellTouch(index: index)
  }
}

extension MDCategoryCollectionCell {
  func configure(title: String, itemIndex: Int, delegate customDelegate: MDCategoryTouchProtocol) {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTouched(_:)))
    titleLabel.text = title
    titleLabel.addGestureRecognizer(tapGesture)
    index = itemIndex
    delegate = customDelegate
  }
  private func setupUI() {
    self.contentView.addSubviews([titleLabel])
    
    titleLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
