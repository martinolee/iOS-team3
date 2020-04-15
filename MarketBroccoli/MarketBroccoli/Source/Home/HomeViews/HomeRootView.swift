//
//  HomeRootView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Kingfisher

class HomeRootView: UIView {
  private let selectedCategory = CategorySelected()
  private let scrollView = UIScrollView().then {
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.bounces = false
  }
  
  private let stackView = CategoryStackView(categories: Categories.HomeCategory, distribution: .fillProportionally)
  
  private var categoryArray: [UIView] = []
  private let menuTextArray = Categories.HomeCategory
  private var newModel: [MainItem] = []
  private var bestModel: [MainItem] = []
  private var discountModel: [MainItem] = []
  private var model = [
    RequestHome.new: [MainItem](),
    RequestHome.best: [MainItem]()
  ]
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    dataRequest(type: .new)
    dataRequest(type: .best)
    dataRequest(type: .discount)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension HomeRootView {
  private func dataRequest(type: RequestHome) {
    guard let endPoint = [RequestHome.new, RequestHome.best, RequestHome.discount].first(
      where: { $0 == type })
      else { return }
    RequestManager.shared.homeRequest(url: endPoint, method: .get, count: 50) { [weak self] res in
      guard let self = self else { return }
      switch res {
      case .success(let data):
        self.model[endPoint] = data
        self.categoryArray.forEach {
          guard let category = ($0 as? NewProduct),
            let name = category.collectionName,
            name == endPoint else { return }
          category.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  private func scrollMoved(_ currentPage: Int, scroll: Bool = false) {
    guard let label = stackView.arrangedSubviews[currentPage] as? UILabel else { return }
    stackView.arrangedSubviews.forEach {
      ($0 as? UILabel)?.textColor = .gray
    }
    
    selectedCategory.snp.remakeConstraints {
      $0.bottom.equalTo(label.snp.bottom)
      $0.centerX.equalTo(label.snp.centerX)
      $0.width.equalTo(label.getWidth() ?? 0)
      $0.height.equalTo(4)
    }
    
    UIView.animate(withDuration: 0.3) {
      label.textColor = .kurlyMainPurple
      if scroll {
        let movePoint = CGPoint(x: self.frame.size.width * CGFloat(currentPage), y: 0)
        self.scrollView.setContentOffset(movePoint, animated: false)
      }
      self.layoutIfNeeded()
    }
  }
  
  @objc private func categoryTouched(_ sender: UITapGestureRecognizer) {
    guard let label = sender.view as? UILabel,
      let labelIdx = stackView.arrangedSubviews.firstIndex(of: label)
      else { return }
    scrollMoved(labelIdx, scroll: true)
  }
}

// MARK: - UI
extension HomeRootView {
  private func setupAttr() {
    scrollView.delegate = self
    categoryAddGesture()
  }
  
  private func categoryAddGesture() {
    stackView.subviews.forEach {
      guard let label = $0 as? UILabel else { return }
      let tap = UITapGestureRecognizer(target: self, action: #selector(categoryTouched(_:)))
      label.addGestureRecognizer(tap)
    }
  }
  
  private func setupUI() {
    setupAttr()
    let safeArea = self.safeAreaLayoutGuide
    guard let firstStackViewItem = stackView.arrangedSubviews.first as? UILabel else { return }
    firstStackViewItem.textColor = .kurlyMainPurple
    self.addSubviews([scrollView, stackView])
    stackView.addSubview(selectedCategory)
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(safeArea.snp.top)
      $0.leading.trailing.equalTo(self)
    }
    
    selectedCategory.snp.makeConstraints {
      $0.bottom.equalTo(firstStackViewItem.snp.bottom)
      $0.centerX.equalTo(firstStackViewItem.snp.centerX)
      $0.width.equalTo(firstStackViewItem.getWidth() ?? 0)
      $0.height.equalTo(5)
    }
    
    scrollView.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom)
      $0.leading.bottom.trailing.equalTo(safeArea)
    }
    
    let categoryCnt = menuTextArray.count
    for idx in menuTextArray.indices {
      switch idx {
      case 0:
        categoryArray.append(RecommendationView())
      case 1...categoryCnt - 2:
        let product = NewProduct(frame: .zero, collectionViewLayout: CustomCollectionViewFlowLayout())
        product.dataSource = self
        product.delegate = self
        product.register(cell: ProductCollectionCell.self)
        switch menuTextArray[idx] {
        case "알뜰쇼핑": product.collectionName = RequestHome.discount
        case "베스트": product.collectionName = RequestHome.best
        case "신상품": product.collectionName = RequestHome.new
        default:
          print("pass")
        }
        categoryArray.append(product)
      case categoryCnt - 1:
        categoryArray.append(RecommendationView())
      default:
        fatalError("out of range")
      }
    }
    makeCategoryConstraint(target: scrollView, categories: categoryArray)
  }
}

// MARK: - ScrollViewDelegate
extension HomeRootView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let screenWidth = self.scrollView.frame.size.width
    let currentOffsetX = scrollView.contentOffset.x
    guard screenWidth > 0 && currentOffsetX > 0 else { return }
    let currentPage = Int((currentOffsetX + (screenWidth / 2)) / screenWidth)
    scrollMoved(currentPage)
  }
}

extension HomeRootView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat { 20 }
  
  // 최소 아이템 간격
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 8 }
  
  // 컬렉션 뷰 인셋
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
  }
  
  // 아이템 사이즈
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemWidth = ((self.frame.width - (8 * 2) - (8 * (2 - 1))) / 2).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth * 1.8)
  }
}

// MARK: - CollectionViewDelegate
extension HomeRootView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    ObserverManager.shared.post(
      observerName: .productTouched,
      object: nil,
      userInfo: ["indexPath": indexPath])
  }
}

// MARK: - CollectionViewDataSource
extension HomeRootView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let collectionView = collectionView as? NewProduct,
      let name = collectionView.collectionName else { return 0 }
    return model[name]?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let collectionView = collectionView as? NewProduct,
    let name = collectionView.collectionName else { return UICollectionViewCell() }
    let cellItem = model[name] ?? [MainItem]()
    let cell = collectionView.dequeue(ProductCollectionCell.self, indexPath: indexPath)
    let asd = cellItem[indexPath.item]
    
    cell.configure(
      productName: asd.name,
      productImage: asd.thumbImage,
      price: asd.price,
      discount: asd.discountRate,
      additionalInfo: [],
      isSoldOut: false,
      productIndexPath: indexPath
    )
    return cell
  }
}
