//
//  CategoryDetailViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/13.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class CategoryDetailViewController: UIViewController {
  // MARK: - Properties
  private var customMenuBar = CategoryDetailHeaderView()
  let customMenuBarheigt: CGFloat = 50
  private lazy var collectionViewFlowLayout = UICollectionViewFlowLayout()
  private lazy var collectionView = UICollectionView(
    frame: .init(
      x: 0, y: customMenuBarheigt,
      width: view.frame.width,
      height: view.frame.height - customMenuBarheigt), // .zero로 했을 때 안나오는 문제 해결 할 것
    collectionViewLayout: collectionViewFlowLayout)
    .then {
      $0.isPagingEnabled = true
      $0.register(cell: UICollectionViewCell.self, forCellReuseIdentifier: "cell")
      $0.register(cell: CategoryDetailCollectionViewCell.self)
  }
  var categoryDetailNavigationTitle = ""
  var selectedCellTitle = ""
  var categoryId: Int? {
    didSet {
      // categoryData[section].count
      print("didSet categoryID")
    }
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    setupNavigtion()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews() // 타이밍이 컬렉션뷰 레이아웃이 잡히고
    // 그 다음에 플로우레이아웃이 잡혀야
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
    guard let categoryId = categoryId else { return }
//    customMenuBar.title(name: categoryData[categoryId - 1].row[1])
    customMenuBar.categories(categories: categoryData[categoryId - 1].row)
    [collectionView, customMenuBar] .forEach {
      view.addSubview($0)
    }
  }
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    collectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom)
    }
    customMenuBar.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.height.equalTo(customMenuBarheigt)
      $0.bottom.equalTo(collectionView.snp.top)
    }
  }
  private func setupNavigtion() {
    self.addSubNavigationBarCartButton()
    self.setupSubNavigationBar(title: categoryDetailNavigationTitle)
  }
  private func setupFlowLayout() {
    let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    collectionViewFlowLayout.sectionInset = insets
    collectionViewFlowLayout.minimumLineSpacing = 0
    collectionViewFlowLayout.minimumInteritemSpacing = 0
    collectionViewFlowLayout.itemSize = CGSize(
      width: collectionView.frame.width,
      height: collectionView.frame.height
    )
    collectionViewFlowLayout.scrollDirection = .horizontal
  }
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let categoryId = categoryId else { return 0 }
    return categoryData[categoryId - 1].row.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let categoryId = categoryId else { return UICollectionViewCell() }
    let cell = collectionView.dequeue(CategoryDetailCollectionViewCell.self, indexPath: indexPath)
    print(selectedCellTitle)
    cell.configure(id: categoryId)
    return cell
  }
}
