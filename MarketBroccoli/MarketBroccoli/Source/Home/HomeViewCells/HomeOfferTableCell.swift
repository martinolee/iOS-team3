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
  
  private let cellSubtitleLabel = UILabel().then {
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
    $0.isHidden = false
  }
  
  private let offerCollectionView = HomeProductCollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )

  var offset: CGFloat {
    get {
      self.offerCollectionView.contentOffset.x
    }
    set {
      self.offerCollectionView.contentOffset.x = newValue
    }
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
  
  override func prepareForReuse() {
    super.prepareForReuse()
    cellSubtitleLabel.text = ""
    cellSubtitleLabel.isHidden = true
    self.backgroundColor = .clear
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTION Handler
extension HomeOfferTableCell {
  func configure(cellTitle title: String, subtitle: String? = nil) {
    cellTitleLabel.text = title
    if let subtitle = subtitle {
      cellSubtitleLabel.text = subtitle
      cellSubtitleLabel.isHidden = false
    }
  }
}

// MARK: - UI
extension HomeOfferTableCell {
  private func setupLayout() {
    guard let layout = offerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
    layout.scrollDirection = .horizontal
  }
  
  private func setupAttr() {
    offerCollectionView.register(cell: HomeProductCollectionCell.self)
    offerCollectionView.register(cell: HomeReuseShowAllCollectionCell.self)
    offerCollectionView.dataSource = self
    offerCollectionView.delegate = self
  }
  
  private func setupUI() {
    self.contentView.addSubviews([cellTitleLabel, cellSubtitleLabel, offerCollectionView])
    
    cellTitleLabel.snp.makeConstraints {
      $0.top.equalTo(self.contentView)
      $0.leading.equalToSuperview().inset(10)
    }
    
    cellSubtitleLabel.snp.makeConstraints {
      $0.top.equalTo(cellTitleLabel.snp.bottom).offset(4)
      $0.leading.equalToSuperview().inset(10)
    }
    
    offerCollectionView.snp.makeConstraints {
      $0.top.equalTo(cellSubtitleLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
      $0.height.equalTo(200)
    }
  }
}

// MARK: - DataSource
extension HomeOfferTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    9
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if indexPath.item <= 7 {
      return offerCollectionView.dequeue(HomeProductCollectionCell.self, indexPath: indexPath)
    } else {
      let cell = offerCollectionView.dequeue(HomeReuseShowAllCollectionCell.self, indexPath: indexPath)
      return cell
    }
  }
}

// MARK: - Delegate
extension HomeOfferTableCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    ObserverManager.shared.post(
      observerName: .productTouched,
      object: nil,
      userInfo: ["indexPath": indexPath])
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    if indexPath.item == 8 {
      return CGSize(width: 120, height: 200)
    } else {
      let margin: CGFloat = 10
      let itemCount: CGFloat = 2.3
      let contentSize: CGFloat = ((self.frame.width - (margin * 2) - (10 * (itemCount - 1))) / itemCount).rounded(.down)
      return CGSize(width: contentSize, height: 200)
    }
  }
}
