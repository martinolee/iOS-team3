//
//  RecommendationTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/07.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
  // MARK: - Properties
  static let identifier: String = "recommendationTableViewCell"
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
    $0.backgroundColor = .white
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    setupLayout()
  }
  private func setupUI() {
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.register(cell: RecommendationCollectionViewCell.self)
    [collectionView].forEach {
      contentView.addSubview($0)
    }
  }
  private func setupLayout() {
    collectionView.snp.makeConstraints { make -> Void in
      make.edges.equalToSuperview()
    }
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendationTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 8
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UICollectionViewCell!
    let customcell = collectionView.dequeue(RecommendationCollectionViewCell.self, indexPath: indexPath)
    cell = customcell
    customcell.configure(image: UIImage(named: "채소_검정"), title: "짜란")
    return cell
  }
}
