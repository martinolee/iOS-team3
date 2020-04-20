//
//  CategoryDetailViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/13.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit

class CategoryDetailViewController: UIViewController {
  // MARK: - Properties
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(
    frame: .init(x: 0, y: 0, width: 300, height: 800), // .zero로 했을 때 안나오는 문제 해결 할 것
    collectionViewLayout: collectionViewFlowLayout)
    .then {
      $0.backgroundColor = .systemBlue
      $0.register(cell: UICollectionViewCell.self, forCellReuseIdentifier: "cell")
  }
  var categoryDetailNavigationTitle = ""
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    setupNavigtion()
  }
//  override func viewWillLayoutSubviews() {
//    setupFlowLayout()
//  }
  override func viewWillAppear(_ animated: Bool) {
    setupFlowLayout()
  }
  override func viewWillDisappear(_ animated: Bool) {
    self.setupBroccoliNavigationBar(title: "카테고리")
    self.addNavigationBarCartButton()
  }
  // MARK: - Setup Attribute
  private func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    collectionView.dataSource = self
//    collectionView.delegate = self
    [collectionView] .forEach {
      view.addSubview($0)
    }
  }
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    collectionView.snp.makeConstraints {
      $0.edges.equalTo(guide.snp.edges)
      $0.width.equalTo(guide.snp.width)
      $0.height.equalTo(guide.snp.height)
    }
  }
  private func setupNavigtion() {
    self.addSubNavigationBarCartButton()
    self.setupSubNavigationBar(title: categoryDetailNavigationTitle)
  }
  private func setupFlowLayout() {
     let minimumLineSpacing: CGFloat = 10.0
     let minimumInteritemSpacing: CGFloat = 10.0
     let insets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
     let itemsForLine: CGFloat = 2
     let itemSizeWidth = (
       (
         collectionView.frame.width - (
           insets.left + insets.right + minimumInteritemSpacing * (itemsForLine - 1))
         ) / itemsForLine
       ).rounded(.down)
     let itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth - 8)
     collectionViewFlowLayout.sectionInset = insets
     collectionViewFlowLayout.minimumLineSpacing = minimumLineSpacing
     collectionViewFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
     collectionViewFlowLayout.itemSize = itemSize
     collectionViewFlowLayout.scrollDirection = .vertical
   }
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    cell.backgroundColor = .systemPink
    return cell
  }
}
