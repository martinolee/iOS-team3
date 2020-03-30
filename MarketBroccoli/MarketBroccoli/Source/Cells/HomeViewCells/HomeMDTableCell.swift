//
//  HomeMDTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/26.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeMDTableCell: UITableViewCell {
  private let cellTitleLabel = UILabel().then {
    $0.text = "MD의 추천"
  }
  private let seperatorTop = Seperator()
  private let MDcategoryCollectionView = HomeProductCollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  private let seperatorBottom = Seperator()
  private let MDProductCollectionView = HomeProductCollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  
  private let categoryArray = Categories.HomeMDCategory
  
  enum UI {
    static let inset: CGFloat = 10
    static let spacing: CGFloat = 10
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    setupAttr()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UI
extension HomeMDTableCell {
  private func setupAttr() {
    [MDcategoryCollectionView, MDProductCollectionView].forEach {
      $0.dataSource = self
      $0.delegate = self
      ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
      $0.register(cell: UICollectionViewCell.self)
    }
  }
  
  private func setupUI() {
    self.contentView.addSubviews(
      [cellTitleLabel, seperatorTop, MDcategoryCollectionView, seperatorBottom, MDProductCollectionView]
    )
    
    cellTitleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    seperatorTop.snp.makeConstraints {
      $0.top.equalTo(cellTitleLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
      $0.height.equalTo(1)
    }
    
    MDcategoryCollectionView.snp.makeConstraints {
      $0.top.equalTo(seperatorTop.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    seperatorBottom.snp.makeConstraints {
      $0.top.equalTo(MDcategoryCollectionView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
      $0.height.equalTo(1)
    }
    
    MDProductCollectionView.snp.makeConstraints {
      $0.top.equalTo(MDcategoryCollectionView.snp.bottom).offset(20)
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(410)
    }
  }
}

extension HomeMDTableCell: UICollectionViewDelegateFlowLayout {
  // 위아래간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    UI.spacing
  }
  
  // 최소 아이템 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case MDcategoryCollectionView:
      return 20
    case MDProductCollectionView:
      return 10
    default:
      fatalError()
    }
  }
  
  // 컬렉션 뷰 인셋
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 0, left: UI.inset, bottom: 0, right: UI.inset)
  }
  
  // 아이템 사이즈
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {
    case MDcategoryCollectionView:
      let label = UILabel().then { $0.text = categoryArray[indexPath.row] }
      return CGSize(width: label.getWidth() ?? 0, height: 30)
    case MDProductCollectionView:
      return CGSize(
        width: ((self.frame.width - (UI.inset * 2) - (UI.spacing * 2)) / 3).rounded(.down),
        height: 200
      )
    default:
      fatalError("CollectionView Not Found")
    }
  }
}

extension HomeMDTableCell: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let cellWidth = ((self.frame.width - (UI.inset * 2) - (UI.spacing * 2)) / 3).rounded(.down) * 3 + (UI.inset + UI.spacing * 2)
    var page = round(MDProductCollectionView.contentOffset.x / cellWidth)
    if velocity.x > 0 {
      page += 1
    }
    if velocity.x < 0 {
      page -= 1
    }
    page = max(page, 0)
    targetContentOffset.pointee.x = page * cellWidth
  }
}

// MARK: - DataSource
extension HomeMDTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case MDcategoryCollectionView:
      return categoryArray.count
    case MDProductCollectionView:
      return 200
    default:
      fatalError("CollectionView Not Found")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case MDcategoryCollectionView:
      let cell = collectionView.dequeue(UICollectionViewCell.self, indexPath: indexPath)
      cell.backgroundColor = .red
      return cell
    case MDProductCollectionView:
      let cell = collectionView.dequeue(UICollectionViewCell.self, indexPath: indexPath)
      
      if indexPath.row % 6 == 0 {
        cell.backgroundColor = .gray
      } else {
        cell.backgroundColor = .blue
      }
      return cell
    default:
      fatalError("CollectionView Not Found")
    }
  }
}
