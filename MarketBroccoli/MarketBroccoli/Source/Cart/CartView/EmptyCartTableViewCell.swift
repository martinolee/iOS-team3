//
//  EmptyCartTableViewCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class EmptyCartTableViewCell: UITableViewCell {
  // MARK: - Property
  
  private let emptyMessageLabel = UILabel().then {
    $0.textAlignment = .center
    $0.backgroundColor = .white
    
    $0.text = "장바구니에 담긴 상품이 없습니다."
  }
  
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.addSubview(emptyMessageLabel)
    setupAttribute()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.backgroundColor = .kurlyGray3
  }
  
  private func setupAutoLayout() {
    emptyMessageLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.bottom.trailing.equalToSuperview().inset(8)
      $0.height.equalTo(300)
    }
  }
}
