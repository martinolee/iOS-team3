//
//  IDFindView.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class IDFindView: UIView {
  private var nameTextField = UITextField().then {
    $0.placeholder = "이름을 입력해주세요."
    $0.textFieldStyle()
  }
  private var emailTextField = UITextField().then {
    $0.placeholder = "이메일을 입력해주세요."
    $0.textFieldStyle()
  }
  private var submitButton = UIButton().then {
    $0.setTitle("확인", for: .normal)
    $0.roundPurpleBtnStyle()
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    setupLayout()
  }
  
  private func setupUI() {
    self.backgroundColor = .white
    emailTextField.keyboardType = .emailAddress
    [nameTextField, emailTextField, submitButton].forEach {
      self.addSubview($0)
    }
  }
    private func setupLayout() {
      let margin: CGFloat = 32
      let height: CGFloat = 14
      let buttonTopMargin: CGFloat = 12
      
      nameTextField.snp.makeConstraints {
        $0.height.equalTo(self.snp.height).dividedBy(height)
        $0.top.equalTo(self.snp.top).offset(margin)
        $0.centerX.equalToSuperview()
        $0.width.equalToSuperview().multipliedBy(0.86)
      }
      emailTextField.snp.makeConstraints {
        $0.height.equalTo(self.snp.height).dividedBy(height)
        $0.top.equalTo(nameTextField.snp.bottom).offset(buttonTopMargin)
        $0.centerX.equalToSuperview()
        $0.width.equalToSuperview().multipliedBy(0.86)
      }
      
      submitButton.snp.makeConstraints {
        $0.height.equalTo(self.snp.height).dividedBy(height)
        $0.top.equalTo(emailTextField.snp.bottom).offset(margin)
        $0.centerX.equalToSuperview()
        $0.width.equalToSuperview().multipliedBy(0.86)
      }
    }
    
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
