//
//  CheckBox.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/30.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol CheckBoxDelegate: class {
  func checkBoxTouched(_ checkBox: CheckBox, _ isChecked: Bool)
}

class CheckBox: UIButton {
  // MARK: - Properties
  
  weak var delegate: CheckBoxDelegate?
  
  private var isChecked: Bool {
    didSet {
      isChecked ?
        setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal) :
        setImage(UIImage(systemName: "square"), for: .normal)
    }
  }
  
  // MARK: Life Cycle
  
  private override init(frame: CGRect) {
    isChecked = true
    
    super.init(frame: frame)
    
    setupAttribute()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.do {
      $0.contentMode = .scaleAspectFit
      $0.tintColor = .kurlyMainPurple
      
      $0.addTarget(self, action: #selector(checkBoxTouched(_:)), for: .touchUpInside)
    }
  }
  
  private func setupAutoLayout() {
    self.snp.makeConstraints {
      $0.width.equalTo(25)
      $0.height.equalTo(self.snp.width)
    }
  }
  
  // MARK: - Action Handler
  
  @objc
  private func checkBoxTouched(_ checkBox: CheckBox) {
    isChecked.toggle()
    
    delegate?.checkBoxTouched(checkBox, isChecked)
  }
  
  // MARK: - Elment Control
  
  func setStatus(_ checked: Bool) {
    self.isChecked = checked
  }
}
