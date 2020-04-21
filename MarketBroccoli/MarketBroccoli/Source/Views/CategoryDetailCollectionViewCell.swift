//
//  CategoryDetailCollectionViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDetailCollectionViewCell: UICollectionViewCell {
  // MARK: - Properties
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(
    frame: .zero
    ,
    collectionViewLayout: collectionViewFlowLayout)
    .then {
//      $0.register(cell: UICollectionViewCell.self, forCellReuseIdentifier: "cell")
      $0.register(cell: ProductCollectionCell.self)
  }
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  override func layoutSubviews() {
    setupFlowLayout()
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - Setup Attribute
  private func setupUI() {
    collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
    collectionView.dataSource = self
    //    collectionView.delegate = self
    [collectionView] .forEach {
      contentView.addSubview($0)
    }
    
    collectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  private func setupFlowLayout() {
    let minimumLineSpacing: CGFloat = 20.0
    let minimumInteritemSpacing: CGFloat = 14.0
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    let itemsForLine: CGFloat = 2
    let itemSizeWidth = (
      (
        collectionView.frame.width - (
          insets.left + insets.right + minimumInteritemSpacing * (itemsForLine - 1))
        ) / itemsForLine
      ).rounded(.down)
    let itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth + 146)
    collectionViewFlowLayout.sectionInset = insets
    collectionViewFlowLayout.minimumLineSpacing = minimumLineSpacing
    collectionViewFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
    collectionViewFlowLayout.itemSize = itemSize
    collectionViewFlowLayout.scrollDirection = .vertical
  }
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailCollectionViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 16
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(ProductCollectionCell.self, indexPath: indexPath)
    cell.configure(
      productName: "[함소아] 홍키통키 프라임 블루 3단계",
      productImage: "https://wpsios-s3.s3.ap-northeast-2.amazonaws.com/media/1574668074322y0.jpg",
      price: 91_000,
      discount: 0.3,
      additionalInfo: ["Kurly Only"],
      isSoldOut: false,
      productIndexPath: indexPath
    )
//    cell.backgroundColor = .systemPink
    return cell
  }
}
