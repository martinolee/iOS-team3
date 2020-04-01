//
//  HomeMDTableCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/26.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol MDCategoryTouchProtocol: class {
  func cellTouch(index: Int)
}

class HomeMDTableCell: UITableViewCell {
  private let cellTitleLabel = UILabel().then {
    $0.text = "MD의 추천"
  }
  private let seperatorTop = Seperator()
  private let selectedCategory = CategorySelected()
  private let MDcategoryCollectionView = HomeProductCollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  private lazy var MDCategoryScrollView = CategoryScrollView(categories: categoryArray).then {
    $0.customDelegate = self
  }
  private let seperatorBottom = Seperator()
  private let MDProductCollectionView = HomeProductCollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )
  
  private let categoryArray = Categories.HomeMDCategory
  private var itemWidth: CGFloat = 0
  
  enum UI {
    static let inset: CGFloat = 10
    static let spacing: CGFloat = 10
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    setupAttr()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    itemWidth = ((self.frame.width - (UI.inset * 2) - (UI.spacing * 2)) / 3).rounded(.down)
    
    productMoved(0)
    updateAnimation(movePoint: 0, page: 0, direction: false)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HomeMDTableCell: UICollectionViewDelegateFlowLayout {
  // 위아래간격 horizontal인경우 좌우간격이 된다.
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return UI.spacing
  }
  
  // 최소 아이템 간격
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch collectionView {
    case MDProductCollectionView:
      return 10
    default:
      fatalError()
    }
  }
  
  // 컬렉션 뷰 인셋
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
  }
  
  // 아이템 사이즈
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    switch collectionView {
    case MDProductCollectionView:
      return CGSize(
        width: itemWidth,
        height: 200
      )
    default:
      fatalError("CollectionView Not Found")
    }
  }
}

extension HomeMDTableCell: UIScrollViewDelegate {
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if scrollView == MDProductCollectionView {
      let cellWidth = itemWidth * 3 + (UI.inset + UI.spacing * 2)
      var page = round(MDProductCollectionView.contentOffset.x / cellWidth)
      var isRight = true
      if velocity.x > 0 {
        page += 1
        isRight = true
      }
      if velocity.x < 0 {
        page -= 1
        isRight = false
      }
      page = max(page, 0)
      targetContentOffset.pointee.x = page * cellWidth
      categoryMoved(Int(page), direction: isRight)
    }
  }
}

// MARK: - DataSource
extension HomeMDTableCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch collectionView {
    case MDProductCollectionView:
      return 6 * categoryArray.count
    default:
      fatalError("CollectionView Not Found")
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch collectionView {
    case MDProductCollectionView:
      let cell = collectionView.dequeue(UICollectionViewCell.self, indexPath: indexPath)
      cell.backgroundColor = .blue
      return cell
    default:
      fatalError("CollectionView Not Found")
    }
  }
}

// MARK: - UI
extension HomeMDTableCell {
  private func setupAttr() {
    [MDProductCollectionView].forEach {
      $0.register(cell: UICollectionViewCell.self)
      $0.dataSource = self
      $0.delegate = self
      ($0.collectionViewLayout as? UICollectionViewFlowLayout)?.scrollDirection = .horizontal
    }
  }
  
  private func setupUI() {
    self.contentView.addSubviews(
      [cellTitleLabel, seperatorTop, selectedCategory, MDCategoryScrollView, seperatorBottom, MDProductCollectionView]
    )
    
    cellTitleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0))
    }
    
    seperatorTop.snp.makeConstraints {
      $0.top.equalTo(cellTitleLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
      $0.height.equalTo(1)
    }
    
    MDCategoryScrollView.snp.makeConstraints {
      $0.top.equalTo(seperatorTop.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    seperatorBottom.snp.makeConstraints {
      $0.top.equalTo(MDCategoryScrollView.snp.bottom)
      $0.leading.trailing.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
      $0.height.equalTo(1)
    }
    
    MDProductCollectionView.snp.makeConstraints {
      $0.top.equalTo(MDCategoryScrollView.snp.bottom).offset(20)
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(410)
    }
  }
}

// MARK: - ACTIONS
extension HomeMDTableCell {
  private func categoryMoved(_ currentPage: Int, direction: Bool) {
    var MDTextWidth: CGFloat = 0
    let label = UILabel()
    print(currentPage)
    for i in 0..<currentPage {
      label.text = categoryArray[i]
      MDTextWidth += (label.getWidth() ?? 0) + 10
    }
    let textWidth = (label.getWidth() ?? 0)
    let correction = (self.frame.width / 2) - textWidth + (textWidth / 2) - 10
    let movePoint = MDTextWidth - correction
    updateAnimation(movePoint: movePoint, page: currentPage, direction: direction)
  }
  
  private func updateAnimation(movePoint: CGFloat, page: Int, direction isRight: Bool) {
    guard let item = MDCategoryScrollView.viewWithTag(9999 - page) as? UILabel else { return }
    MDCategoryScrollView.subviews.forEach {
      ($0 as? UILabel)?.textColor = .gray
    }
    
    selectedCategory.snp.remakeConstraints {
      $0.top.equalTo(item.snp.bottom)
      $0.leading.trailing.width.equalTo(item)
      $0.height.equalTo(2)
    }
    
    UIView.animate(withDuration: 0.3) {
      item.textColor = .kurlyPurple
      if 2...11 ~= page {
        self.MDCategoryScrollView.setContentOffset(CGPoint(x: movePoint, y: 0), animated: false)
      } else if 0...1 ~= page {
        self.MDcategoryCollectionView.setContentOffset(CGPoint(x: -10, y: 0), animated: false)
      } else {
        self.MDCategoryScrollView.setContentOffset(CGPoint(x: self.MDCategoryScrollView.maxContentOffset.x, y: 0), animated: false)
      }
      self.layoutIfNeeded()
    }
  }
  
  private func productMoved(_ currentPage: Int) {
    let movePoint = CGPoint(x: (self.itemWidth * 3 + (UI.inset + UI.spacing * 2)) * CGFloat(currentPage), y: 0)
    self.MDProductCollectionView.setContentOffset(movePoint, animated: true)
  }
}

extension HomeMDTableCell: MDCategoryTouchProtocol {
  func cellTouch(index: Int) {
    productMoved(index)
    categoryMoved(index, direction: false)
  }
}
