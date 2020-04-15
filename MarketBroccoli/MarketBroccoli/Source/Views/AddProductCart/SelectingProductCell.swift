//
//  SelectingProductCell.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/15.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol SelectingProductCellDelegate: class {
}

class SelectingProductCell: UITableViewCell {
  // MARK: - Properties
  
  weak var delegate: SelectingProductCellDelegate?
  
  private var productIndexPath: IndexPath!
  
  private let priceLabel = UILabel()
  
  private lazy var stepper = ProductQuantityStepper(minimum: 0).then {
    $0.delegate = self
  }
  
  // MARK: - Life Cycle
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SelectingProductCell: ProductQuantityStepperDelegate {
  func valueChanged(_ value: Int) {
  }
}

extension SelectingProductCell {
  func configure(name: String, price: Int, discount: Double, shoppingItemIndexPath: IndexPath) {
    let currentPrice = moneyFormatter(won: price, hasUnit: true)
    
    if discount != 0 {
      let originalPrice = moneyFormatter(won: Int(Double(price) / (1 - discount)), hasUnit: true)
      
      priceLabel.attributedText = NSMutableAttributedString()
        .strikethrough(currentPrice, textColor: .kurlyGray1)
        .normal(originalPrice, fontSize: 17)
    }
    
    priceLabel.attributedText = NSMutableAttributedString()
      .normal(currentPrice, fontSize: 17)
  }
}
