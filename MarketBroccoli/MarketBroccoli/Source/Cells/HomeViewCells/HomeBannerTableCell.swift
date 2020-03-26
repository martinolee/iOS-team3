//
//  HomeBannerTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

class HomeBannerTableCell: UITableViewCell {
  private let dummyData = Array(repeating: ["cloud", "cloud3"], count: 3).flatMap { $0 }
  private lazy var bannerCountLabel = UILabel().then {
    $0.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
    $0.textColor = .white
    $0.layer.cornerRadius = 5
    $0.layer.masksToBounds = true
    $0.text = " 1 / \(dummyData.count) "
  }
  private let bannerCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: CustomCollectionViewFlowLayout()
  ).then {
    $0.isPagingEnabled = true
    $0.bounces = false
    $0.showsHorizontalScrollIndicator = false
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension HomeBannerTableCell {
  private func setupLayout() {
    guard let layout = bannerCollectionView.collectionViewLayout as? CustomCollectionViewFlowLayout else { return }
    layout.minimumLineSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.itemSize = CGSize(width: self.frame.width, height: 300)
  }
  
  private func setupAttr() {
    bannerCollectionView.delegate = self
    bannerCollectionView.dataSource = self
    bannerCollectionView.register(cell: BannerCollectionCell.self)
  }
  
  private func setupUI() {
    self.contentView.addSubview(bannerCollectionView)
    self.contentView.addSubview(bannerCountLabel)
    
    bannerCollectionView.snp.makeConstraints {
      $0.top.leading.bottom.trailing.equalTo(self.contentView)
      $0.height.equalTo(300)
    }
    
    bannerCountLabel.snp.makeConstraints {
      $0.bottom.trailing.equalTo(bannerCollectionView).inset(20)
    }
    
    setupAttr()
  }
}

// MARK: - CollectionView DataSource
extension HomeBannerTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dummyData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      let cell = collectionView.dequeue(BannerCollectionCell.self, indexPath: indexPath)
      cell.configure(image: dummyData[indexPath.item])
      return cell
    default:
      return UICollectionViewCell()
    }
  }
}

// MARK: - CollectionView Delegate
extension HomeBannerTableCell: UICollectionViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let bannerWidth = bannerCollectionView.frame.size.width
    let currentPage = Int(bannerCollectionView.contentOffset.x / bannerWidth)
    
    DispatchQueue.main.async {
      self.bannerCountLabel.text = " \(currentPage + 1) / \(self.dummyData.count) "
    }
  }
}
