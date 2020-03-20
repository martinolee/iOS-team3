//
//  SignUpTableViewCell.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SignUpTableViewCell: UITableViewCell {
  
  private let idLabel = UILabel()
  private var idTextFeild = UITextField()
  private let checkIDButton = UIButton()
  private let idExplanationLabel = UILabel()
  private let checkingIdLabel = UILabel()
  private let secretNumberLabel = UILabel()
  private var secretTextFeild = UITextField()
  private let checkSecretNumberLabel = UILabel()
  private var checkSecretNumberTextFeild = UITextField()
  private let nameLabel = UILabel()
  private var nameTextFeild = UITextField()
  private let emailLabel = UILabel()
  private var emailTextFeild = UITextField()
  private let cellphoneLabel = UILabel()
  private var cellphoneTextField = UITextField()
  private let receivingCellphoneNumberButton = UIButton()
  private var checkingReceivingNumberTexField = UITextField()
  private let checkingReceivingButton = UIButton()
  private let addressLabel = UILabel()
  private let addressCheckingLabel = UILabel()
  private let searchingAddressButton = UIButton()
  private let birthdayLabel = UILabel()
  private var birthdayTextField = UITextField()
  private let genderLabel = UILabel()
  private let maleLabel = UILabel()
  private let femaleLabel = UILabel()
  private let noChoice = UILabel()
  private let additionalConditionLabel = UILabel()
  private let additionalExplanationLabel = UILabel()
  private let recoIDLabel = UILabel()
  private let eventName = UILabel()
  
  
//  private let signUpInfos = ["아이디", "비밀번호", "비밀번호 확인", "이름", "이메일", "휴대폰"]
//  private var infoLabels = [UILabel]()
//  private var infoTextfields = [UITextField]()
//  private var infoInputForm = [UIStackView]()
  
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
//    signUpInfos.forEach {
//      let label = UILabel()
//      label.text = $0
//      infoLabels.append(label)
//
//      let textField = textFieldStyle(placeholder: "abc")
//      infoTextfields.append(textField)
//
//      let stackView = UIStackView()
//      stackView.axis = .vertical
//      stackView.alignment = .leading
//      stackView.distribution = .fillProportionally
//      stackView.spacing = 4
//      stackView.addArrangedSubview(label)
//      stackView.addArrangedSubview(textField)
//      infoInputForm.append(stackView)
//    }
  
  }
  private func setupUI() {
    
    idLabel.text = "아이디"
    idTextFeild = self.textFieldStyle(placeholder: "예: marketkurly12")
    checkIDButton.setTitle("중복확인", for: .normal)
    checkIDButton.backgroundColor = .purple
    checkIDButton.setTitleColor(.white, for: .normal)
    
    
  }
  private func constraints() {
    
    idLabel.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(10)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).dividedBy(10)
    }
    
    idTextFeild.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(160)
      $0.leading.equalTo(self.snp.leading).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.6)
    }
    
    checkIDButton.snp.makeConstraints {
      $0.top.equalTo(self.snp.top).offset(160)
      $0.leading.equalTo(idTextFeild.snp.trailing).offset(10)
      $0.width.equalTo(self.snp.width).multipliedBy(0.2)
    }
    
    
  }

  
  

  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension SignUpTableViewCell {
  func textFieldStyle(placeholder: String) -> UITextField {
      let textField = UITextField()
      textField.placeholder = placeholder
      textField.borderStyle = .roundedRect
      textField.clearButtonMode = .whileEditing
      return textField
  }
}
