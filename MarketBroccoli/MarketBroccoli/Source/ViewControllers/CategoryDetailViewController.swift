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
  var categoryDetatilMenuBarTitle = ""
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupLayout()
    setupNavigtion()
  }
//  override func viewWillLayoutSubviews() {
//    super.viewWillLayoutSubviews()
//    customMenuBar.layer.borderWidth = 1
//    customMenuBar.layer.borderColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
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
    customMenuBar.title(name: "채소야 나와라 이렇게 길게 텍스트가 길어진다면 어떻게 나올지 너무 궁금한데 스크롤 뷰가 되는지 안되는지 말이야")
    [collectionView, customMenuBar] .forEach {
      view.addSubview($0)
    }
  }
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    customMenuBar.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
      $0.width.equalTo(800)
      $0.height.equalTo(customMenuBarheigt)
    }
    collectionView.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top).offset(customMenuBarheigt)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(guide.snp.bottom)
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
      height: collectionView.frame.height - customMenuBarheigt
    )
    collectionViewFlowLayout.scrollDirection = .horizontal
  }
}

// MARK: - UICollectionViewDataSource
extension CategoryDetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//    return categoryDetatilMenuBarTitle.count
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(CategoryDetailCollectionViewCell.self, indexPath: indexPath)
    print(categoryDetatilMenuBarTitle)
    return cell
  }
}
