//
//  ShowAllProductViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ShowAllProductViewController: UIViewController {
  private let rootView = ShowAllView()
  
  private var requestKey: RequestHome? {
    willSet {
      if let url = newValue {
        RequestManager.shared.homeRequest(url: url, method: .get, count: 100) {
          switch $0 {
          case .success(let data):
            self.model = data
          case .failure(let error):
            print(error)
          }
        }
      }
    }
  }
  private var model: HomeItems? {
    didSet {
      rootView.collectionView.reloadData()
    }
  }
  
  override func loadView() {
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAttr()
  }
}

// MARK: - ACTIONS
extension ShowAllProductViewController {
  func configure(requestKey key: RequestHome) {
    requestKey = key
  }
}

// MARK: - UI
extension ShowAllProductViewController {
  private func setupAttr() {
    rootView.collectionView.dataSource = self
    rootView.collectionView.delegate = self
    rootView.collectionView.register(cell: ProductCollectionCell.self)
  }
}

// MARK: - CollectionViewDelegate
extension ShowAllProductViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  // FlowLayoutDelegate Start
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
    let itemWidth = ((rootView.frame.width - (8 * 2) - (8 * (2 - 1))) / 2).rounded(.down)
    return CGSize(width: itemWidth, height: itemWidth * 1.8)
  }
  // FlowLayoutDelegate End
  
  // CollectionViewDelegate Start
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let item = model?[indexPath.item] else { return }
    let detailVC = DetailViewController()
    detailVC.configure(productId: item.id)
    self.navigationController?.pushViewController(detailVC, animated: true)
  }
  // CollectionViewDelegate End
}

// MARK: - CollectionViewDataSource
extension ShowAllProductViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    model?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let model = model else { return UICollectionViewCell() }
    let cell = collectionView.dequeue(ProductCollectionCell.self, indexPath: indexPath)
    let item = model[indexPath.item]
    cell.configure(
      productId: item.id,
      productName: item.name,
      productImage: item.thumbImage,
      price: item.price,
      discount: item.discountRate,
      additionalInfo: [],
      isSoldOut: false,
      productIndexPath: indexPath)
    return cell
  }
}
