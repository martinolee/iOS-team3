//
//  SearchView.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/30.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol SearchViewDataSource: class {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

protocol SearchViewDelegate: class {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
  
  func searchProductTextFieldEditingDidBegin(_ textField: UITextField, _ button: UIButton)
  
  func searchProductTextFieldEditingChanged(_ textField: UITextField, _ text: String)
  
  func cancelSearchButtonTouched(_ button: UIButton, _ textField: UITextField)
}

class SearchView: UIView {
  // MARK: - Properties
  
  weak var dataSource: SearchViewDataSource?
  
  weak var delegate: SearchViewDelegate?
  
  private lazy var searchView = UIView().then {
    $0.backgroundColor = .lightGray
  }
  
  private lazy var searchProductTextField = UITextField().then {
    let containerView = UIView().then {
      $0.frame = CGRect(x: 0, y: 0, width: 36, height: 32)
    }
    
    let magnifyingglassImageView = UIImageView().then {
      let magnifyingglassImage = UIImage(systemName: "magnifyingglass")
      
      $0.contentMode = .scaleAspectFit
      $0.image = magnifyingglassImage
      $0.tintColor = .gray
      $0.frame = CGRect(x: 5, y: 0, width: 26, height: 32)
    }
    containerView.addSubview(magnifyingglassImageView)
    
    $0.backgroundColor = .white
    $0.layer.cornerRadius = 6
    $0.leftViewMode = .always
    $0.leftView = containerView
    $0.returnKeyType = .search
    $0.placeholder = "검색어를 입력해 주세요"
    
    $0.addTarget(self, action: #selector(searchProductTextFieldEditingDidBegin(_:)), for: .editingDidBegin)
    $0.addTarget(self, action: #selector(searchProductTextFieldEditingChanged(_:)), for: .editingChanged)
  }
  
  private lazy var cancelSearchButton = UIButton(type: .system).then {
    $0.setTitle("취소", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.setTitleColor(.gray, for: .disabled)
    $0.isEnabled = false
    
    $0.addTarget(self, action: #selector(cancelSearchButtonTouched(_:)), for: .touchUpInside)
  }
  
  private lazy var searchResultCollectionViewFlowLayout = UICollectionViewFlowLayout()
  
  private lazy var searchResultCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: searchResultCollectionViewFlowLayout
  ).then {
    $0.backgroundColor = .white
    
    $0.register(cell: ProductCollectionCell.self)
    
    $0.dataSource = self
    $0.delegate = self
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAttribute()
    addAllView()
    setupAutoLayout()
    setupFlowLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    setupFlowLayout()
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .white
  }
  
  private func addAllView() {
    self.addSubviews([
      searchView,
      searchResultCollectionView
    ])
    
    searchView.addSubviews([
      searchProductTextField,
      cancelSearchButton
    ])
  }
  
  private func setupAutoLayout() {
    let safeArea = self.safeAreaLayoutGuide
    
    searchView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safeArea)
      $0.height.equalTo(50)
    }
    
    searchProductTextField.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview().inset(6)
      $0.trailing.equalTo(cancelSearchButton.snp.leading).inset(-8)
    }
    
    cancelSearchButton.snp.makeConstraints {
      $0.top.bottom.equalTo(searchProductTextField)
      $0.trailing.equalToSuperview().inset(8)
    }
    
    searchResultCollectionView.snp.makeConstraints {
      $0.top.equalTo(searchView.snp.bottom)
      $0.leading.trailing.equalTo(searchView)
      $0.bottom.equalTo(safeArea)
    }
  }
  
  private func setupFlowLayout() {
    let minimumLineSpacing: CGFloat = 8.0
    let minimumInteritemSpacing: CGFloat = 8.0
    let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    let itemsForLine: CGFloat = 2
    let itemSizeWidth = (
      (
        searchResultCollectionView.frame.width - (
          insets.left + insets.right + minimumInteritemSpacing * (itemsForLine - 1))
        ) / itemsForLine
      ).rounded(.down)
    let itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth * 1.8)

    searchResultCollectionViewFlowLayout.sectionInset = insets
    searchResultCollectionViewFlowLayout.minimumLineSpacing = minimumLineSpacing
    searchResultCollectionViewFlowLayout.minimumInteritemSpacing = minimumInteritemSpacing
    searchResultCollectionViewFlowLayout.itemSize = itemSize
    searchResultCollectionViewFlowLayout.scrollDirection = .vertical
  }
}

extension SearchView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    dataSource?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    dataSource?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
  }
}

extension SearchView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.collectionView(collectionView, didSelectItemAt: indexPath)
  }
}

// MARK: - Action Handler

extension SearchView {
  @objc
  private func searchProductTextFieldEditingChanged(_ textField: UITextField) {
    delegate?.searchProductTextFieldEditingChanged(textField, textField.text ?? "")
  }
  
  @objc
  private func searchProductTextFieldEditingDidBegin(_ textField: UITextField) {
    delegate?.searchProductTextFieldEditingDidBegin(textField, cancelSearchButton)
  }
  
  @objc
  private func cancelSearchButtonTouched(_ button: UIButton) {
    delegate?.cancelSearchButtonTouched(button, searchProductTextField)
  }
}

// MARK: - Element Control

extension SearchView {
}
