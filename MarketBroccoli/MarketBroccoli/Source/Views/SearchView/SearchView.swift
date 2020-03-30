//
//  SearchView.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/30.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
}

class SearchView: UIView {
  // MARK: - Properties
  
  weak var delegate: SearchViewDelegate?
  
  private lazy var searchProductTextField = UITextField().then {
    $0.addTarget(self, action: #selector(searchProductTextFieldEditingChanged(_:)), for: .editingChanged)
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Action Handler

extension SearchView {
  @objc
  private func searchProductTextFieldEditingChanged(_ textField: UITextField) {
    
  }
}
