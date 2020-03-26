//
//  HomeOfferTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeOfferTableCell: UITableViewCell {
  private let cellTitleLabel = UILabel().then {
    $0.font = .boldSystemFont(ofSize: 20)
  }
  
  private let offerCollectionView = HomeProductCollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    $0.backgroundColor = .clear
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    setupAttr()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTION Handler
extension HomeOfferTableCell {
  func configure(cellTitle title: String) {
    cellTitleLabel.text = title
  }
}

// MARK: - UI
extension HomeOfferTableCell {
  private func setupLayout() {
    guard let layout = offerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    let margin: CGFloat = 10
    let itemCount: CGFloat = 2.3
    let contentSize: CGFloat = ((self.frame.width - (margin * 2) - (10 * (itemCount - 1))) / itemCount).rounded(.down)
    layout.scrollDirection = .horizontal
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: contentSize, height: 160)
  }
  
  private func setupAttr() {
    offerCollectionView.register(cell: HomeProductCollectionCell.self)
    offerCollectionView.dataSource = self
  }
  
  private func setupUI() {
    self.contentView.addSubviews([cellTitleLabel, offerCollectionView])
    
    cellTitleLabel.snp.makeConstraints {
      $0.top.equalTo(self.contentView)
      $0.leading.equalToSuperview().inset(10)
    }
    
    offerCollectionView.snp.makeConstraints {
      $0.top.equalTo(cellTitleLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
      $0.height.equalTo(200)
    }
  }
}

extension HomeOfferTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    offerCollectionView.dequeue(HomeProductCollectionCell.self, indexPath: indexPath)
  }
}
