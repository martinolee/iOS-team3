//
//  testUIView.swift
//  20200112ScrollViewPractice
//
//  Created by macbook on 2020/03/23.
//  Copyright © 2020 Lance. All rights reserved.
//

import UIKit

class SignupView: UIView, UITextFieldDelegate  {
  private lazy var idLabel = UILabel().then {
    let text = putAsteriskBehind(text: "아이디")
    $0.attributedText = text
  }
  var myMutableString = NSMutableAttributedString()
  private var idTextFeild = UITextField().then {
    $0.placeholder = "예: marketkurly12"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private let checkIDButton = UIButton().then {
    $0.setTitle("중복확인", for: .normal)
    $0.backgroundColor = .purple
    $0.setTitleColor(.white, for: .normal)
  }
  private let idLimitExplanationLabel = UILabel().then {
    $0.text = "6자 이상의 영문 혹은 영문과 숫자를 조합"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 10)
  }
  private let checkingIdLabel = UILabel().then {
    $0.text = "아이디 중복확인"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 10)
  }
  private lazy var secretNumberLabel = UILabel().then {
    let text = putAsteriskBehind(text: "비밀번호")
    $0.attributedText = text
  }
  private var secretTextFeild = UITextField().then {
    $0.placeholder = "비밀번호를 입력해주세요"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private let tenSyllableLabel = UILabel().then {
    $0.text = "10자 이상 입력"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 10)
  }
  private let combinationLabel = UILabel().then {
    $0.text = "영문/숫자/특수문자(공백제외)만 허용하며, 2개 이상 조합"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 10)
  }
  private let notSameTheeNumber = UILabel().then {
    $0.text = "동일한 숫자 3개 이상 연속 사용 불가"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 10)
  }
  private lazy var checkSecretNumberLabel = UILabel().then {
    let text = putAsteriskBehind(text: "비밀번호 확인")
    $0.attributedText = text
    }
  private var checkSecretNumberTextFeild = UITextField().then {
    $0.placeholder = "비밀번호를 한번 더 입력해주세요"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private let sameSecretNumberLabel = UILabel().then {
    $0.text = "동일한 비밀번호를 입력해주세요"
    $0.textColor = .orange
    $0.font = .systemFont(ofSize: 10)
  }
  
  private lazy var nameLabel = UILabel().then {
    let text = putAsteriskBehind(text: "이름")
    $0.attributedText = text
    }
  private var nameTextFeild = UITextField().then {
    $0.placeholder = "고객님의 이름을 입력해주세요"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private let emailLabel = UILabel().then {
    $0.text = "이메일"
  }
  private var emailTextFeild = UITextField().then { $0.placeholder = "예: marketkurly@kurly.com"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private lazy var cellphoneLabel = UILabel().then {
    let text = putAsteriskBehind(text: "휴대폰")
    $0.attributedText = text
  }
  private var cellphoneTextField = UITextField().then {
    $0.placeholder = "'-' 없이 숫자만"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private let receivingCellphoneNumberButton = UIButton().then {
    $0.setTitle("인증번호 받기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .gray
  }
  private var checkingReceivingNumberTexField = UITextField().then {
    $0.placeholder = ""
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
  }
  private let checkingReceivingButton = UIButton().then {
    $0.setTitle("인증번호 확인", for: .normal)
    $0.setTitleColor(.gray, for: .normal)
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.backgroundColor = .white
  }
  private let addressLabel = UILabel().then {
    $0.text = "배송주소"
  }
  private let addressCheckingLabel = UILabel().then {
    $0.text = "배송 가능 여부를 확인할 수 있습니다."
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = .lightGray
  }
  private let searchingAddressButton = UIButton().then {
    $0.setTitle("주소 검색", for: .normal)
    $0.backgroundColor = .purple
    $0.setTitleColor(.white, for: .normal)
  }
  private let birthdayLabel = UILabel().then {
    $0.text = "생년월일"
  }
  private let bunchBirthdayView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private lazy var birthdayYearTextField = UITextField().then {
    $0.placeholder = "YYYY"
    $0.borderStyle = .none
    $0.textAlignment = .center
    $0.delegate = self
  }
  private let firstSlashLabel = UILabel().then {
    $0.text = "/"
  }
  private lazy var birthdayMonthTextField = UITextField().then {
    $0.placeholder = "MM"
    $0.borderStyle = .none
    $0.textAlignment = .center
    $0.delegate = self
  }
  private let secondSlashLabel = UILabel().then {
    $0.text = "/"
  }
  private lazy var birthdayDayTextField = UITextField().then {
    $0.placeholder = "DD"
    $0.borderStyle = .none
    $0.textAlignment = .center
    $0.delegate = self
  }
  private let genderLabel = UILabel().then {
    $0.text = "성별"
  }
  private let maleRoundLabel = UILabel().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let maleLabel = UILabel().then {
    $0.text = "남자"
  }
  private let maleUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let femaleRoundLabel = UILabel().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let femaleLabel = UILabel().then {
    $0.text = "여자"
  }
  private let femaleUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let noChoiceRoundLabel = UILabel().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let noChoiceLabel = UILabel().then {
    $0.text = "선택안함"
  }
  private let noChoiceUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let additionalConditionLabel = UILabel().then {
    $0.text = "추가입력 사항"
  }
  private let additionalExplanationLabel = UILabel().then {
    $0.text = "추천인 아이디와 참여 이벤트명 중 하나마나 선택 가능합니다."
    $0.font = .systemFont(ofSize: 12)
    $0.textColor = .gray
  }
  private let recoRoundLabel = UILabel().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let recoIDLabel = UILabel().then {
    $0.text = "추천인 아이디"
  }
  private let recoUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let eventNameRoundLabel = UILabel().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let eventName = UILabel().then {
    $0.text = "참여 이벤트명"
  }
  private let eventNameUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let scrollView = UIScrollView()
  private let grayView = UIView().then {
    $0.backgroundColor = .gray
  }
  private lazy var usingAgreement = UILabel().then {
    $0.font = .systemFont(ofSize: 15, weight: .bold)
    let text = putAsteriskBehind(text: "이용약관동의")
    $0.attributedText = text
  }
  private let totalAgreeView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let totalAgreeLabel = UILabel().then {
    $0.text = "전체동의"
  }
  private let usingLawView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let usingLawLabel = UILabel().then {
    $0.text = "이용약관"
  }
  private let usingLawEssentialLabel = UILabel().then {
    $0.text = "(필수)"
    $0.textColor = .lightGray
  }
  private let usingLawButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.purple, for: .normal)
  }
  private let personalEssentialView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let personalEssentialLabel = UILabel().then {
    $0.text = "개인정보처리방침"
  }
  private let personalEssentialNeedLabel = UILabel().then {
    $0.text = "(필수)"
    $0.textColor = .lightGray
  }
  private let personalEssentialButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.purple, for: .normal)
  }
  private let personalNotEssentialView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let personalNotEssentialLabel = UILabel().then {
    $0.text = "개인정보처리방침"
  }
  private let personalNotEssentialNeedLabel = UILabel().then {
    $0.text = "(선택)"
    $0.textColor = .lightGray
  }
  private let personalNotEssentialButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.purple, for: .normal)
  }
  private let freeShippingView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let freeShippingLabel = UILabel().then {
    $0.text = "무료배송, 할인쿠폰 등 혜택/정보 수신"
  }
  private let freeShippingCheckLabel = UILabel().then {
    $0.text = "(선택)"
    $0.textColor = .lightGray
  }
  private let smsView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let smsLabel = UILabel().then {
    $0.text = "SMS"
  }
  private let emailCheckView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let emailCheckLabel = UILabel().then {
    $0.text = "이메일"
  }
  private let purchaseAdsView = UIImageView().then {
    $0.image = UIImage(named: "구매혜택")
  }
  private let ageView = UIView().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let ageLabel = UILabel().then {
    $0.text = "본인은 만 14세 이상입니다."
  }
  private let ageEssentialLabel = UILabel().then {
    $0.text = "(필수)"
    $0.textColor = .lightGray
  }
  private let signupButton = UIButton().then {
    $0.setTitle("가입하기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .purple
  }
  private let lastExplainationLabel = UILabel().then {
    $0.text = "선택항목에 동의하지 않은 경우도 회원가입 및 일반적인 서비스를 이용할 수 \n있습니다."
    $0.textColor = .lightGray
    $0.textAlignment = .center
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 12)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    scrollView.backgroundColor = .white
    setupUI()
    layoutSubviews()
  }

  override func layoutSubviews() {
    makeRoundCorner(label: femaleRoundLabel)
    makeRoundCorner(label: maleRoundLabel)
    makeRoundCorner(label: noChoiceRoundLabel)
    makeRoundCorner(label: recoRoundLabel)
    makeRoundCorner(label: eventNameRoundLabel)
  }
  
  private func makeRoundCorner(label: UILabel) {
    label.layer.masksToBounds = true
    label.layer.cornerRadius = label.bounds.height / 2
  }
  private func setupUI() {
    [idLabel, idTextFeild, checkIDButton,
     secretNumberLabel, secretTextFeild, checkSecretNumberLabel,
     checkSecretNumberTextFeild, nameLabel, nameTextFeild,
     emailLabel, emailTextFeild, cellphoneLabel,
     cellphoneTextField, receivingCellphoneNumberButton,
     checkingReceivingNumberTexField, checkingReceivingButton,
     addressLabel, addressCheckingLabel, searchingAddressButton,
     birthdayLabel, genderLabel, maleRoundLabel, maleLabel,
     bunchBirthdayView, femaleRoundLabel, noChoiceRoundLabel,
     recoRoundLabel, eventNameRoundLabel, recoUnderline, eventNameUnderline,
     maleUnderline, femaleUnderline, noChoiceUnderline,
     femaleLabel, noChoiceLabel, additionalConditionLabel,
     additionalExplanationLabel, recoIDLabel, eventName, grayView,
     usingAgreement, totalAgreeView, totalAgreeLabel, usingLawView, usingLawLabel, sameSecretNumberLabel,
     usingLawEssentialLabel, usingLawButton, personalEssentialView, personalEssentialLabel,
     tenSyllableLabel, combinationLabel, notSameTheeNumber,
     personalEssentialNeedLabel, personalEssentialButton, personalNotEssentialView, personalNotEssentialLabel,
     personalNotEssentialNeedLabel, personalNotEssentialButton, freeShippingView, freeShippingLabel,
     freeShippingCheckLabel, smsView, smsLabel, emailCheckView, emailCheckLabel,
     purchaseAdsView, ageView, ageLabel, ageEssentialLabel,
     signupButton, lastExplainationLabel, idLimitExplanationLabel, checkingIdLabel].forEach {
      scrollView.addSubview($0)
    }
    
    [birthdayYearTextField, firstSlashLabel,
     birthdayMonthTextField, secondSlashLabel,
     birthdayDayTextField].forEach {
      bunchBirthdayView.addSubview($0)
    }
    
    [scrollView].forEach {
      self.addSubview($0)
    }
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    idLabel.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.top).offset(10)
      $0.leading.equalTo(scrollView.snp.leading).offset(10)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.92)
    }

    idTextFeild.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.top).offset(40)
      $0.leading.equalTo(idLabel)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.7)
    }
    
    checkIDButton.snp.makeConstraints {
      $0.top.equalTo(scrollView.snp.top).offset(40)
      $0.leading.equalTo(idTextFeild.snp.trailing).offset(10)
      $0.trailing.equalTo(idLabel)
    }
    idLimitExplanationLabel.snp.makeConstraints {
      $0.top.equalTo(idTextFeild.snp.bottom).offset(4)
      $0.leading.equalTo(idTextFeild)
      $0.trailing.equalTo(checkIDButton)
    }
    checkingIdLabel.snp.makeConstraints {
      $0.top.equalTo(idLimitExplanationLabel.snp.bottom).offset(4)
      $0.leading.equalTo(idLimitExplanationLabel)
      $0.trailing.equalTo(idLimitExplanationLabel)
    }
    secretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(checkingIdLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(checkingIdLabel)
    }
    
    secretTextFeild.snp.makeConstraints {
      $0.top.equalTo(secretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(secretNumberLabel)
    }
    
    tenSyllableLabel.snp.makeConstraints {
      $0.top.equalTo(secretTextFeild.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(secretNumberLabel)
    }
    combinationLabel.snp.makeConstraints {
      $0.top.equalTo(tenSyllableLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(tenSyllableLabel)
    }
    
    notSameTheeNumber.snp.makeConstraints {
      $0.top.equalTo(combinationLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(combinationLabel)
    }
    checkSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(notSameTheeNumber.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(notSameTheeNumber)
    }
    
    checkSecretNumberTextFeild.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(checkSecretNumberLabel)
    }
    sameSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberTextFeild.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(checkSecretNumberTextFeild)
    }
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(sameSecretNumberLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(checkSecretNumberTextFeild)
    }
    
    nameTextFeild.snp.makeConstraints {
      $0.top.equalTo(nameLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(nameLabel)
    }
    
    emailLabel.snp.makeConstraints {
      $0.top.equalTo(nameTextFeild.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(nameTextFeild)
    }
    
    emailTextFeild.snp.makeConstraints {
      $0.top.equalTo(emailLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(emailLabel)
    }
    
    cellphoneLabel.snp.makeConstraints {
      $0.top.equalTo(emailTextFeild.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(emailTextFeild)
    }
    
    cellphoneTextField.snp.makeConstraints {
      $0.top.equalTo(cellphoneLabel.snp.bottom).offset(10)
      $0.leading.equalTo(cellphoneLabel)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
    }
    
    receivingCellphoneNumberButton.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField)
      $0.leading.equalTo(cellphoneTextField.snp.trailing).offset(10)
      $0.trailing.equalTo(cellphoneLabel)
    }
    
    checkingReceivingNumberTexField.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField.snp.bottom).offset(10)
      $0.leading.equalTo(cellphoneTextField)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
    }
    
    checkingReceivingButton.snp.makeConstraints {
      $0.top.equalTo(receivingCellphoneNumberButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(receivingCellphoneNumberButton)
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalTo(checkingReceivingNumberTexField.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(cellphoneLabel)
    }
    
    addressCheckingLabel.snp.makeConstraints {
      $0.top.equalTo(addressLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(addressLabel)
    }
    
    searchingAddressButton.snp.makeConstraints {
      $0.top.equalTo(addressCheckingLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(addressCheckingLabel)
    }
    
    birthdayLabel.snp.makeConstraints {
      $0.top.equalTo(searchingAddressButton.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(searchingAddressButton)
    }
    
    bunchBirthdayView.snp.makeConstraints {
      $0.top.equalTo(birthdayLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(birthdayLabel)
      $0.height.equalTo(checkingReceivingNumberTexField)
    }
    
    birthdayYearTextField.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(bunchBirthdayView)
      $0.width.equalTo(scrollView.snp.width).dividedBy(3.2)
    }
    
    firstSlashLabel.snp.makeConstraints {
    $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(birthdayYearTextField.snp.trailing)
      $0.width.equalTo(8)
    }
    
    birthdayMonthTextField.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(firstSlashLabel.snp.trailing)
      $0.width.equalTo(scrollView.snp.width).dividedBy(3.2)
    }
    
    secondSlashLabel.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(birthdayMonthTextField.snp.trailing)
      $0.width.equalTo(8)
    }
    
    birthdayDayTextField.snp.makeConstraints {
      $0.centerY.equalTo(bunchBirthdayView.snp.centerY)
      $0.leading.equalTo(secondSlashLabel.snp.trailing)
      $0.width.equalTo(scrollView.snp.width).dividedBy(3.2)
    }
    
    genderLabel.snp.makeConstraints {
      $0.top.equalTo(bunchBirthdayView.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(searchingAddressButton)
    }
    
    maleRoundLabel.snp.makeConstraints {
      $0.top.equalTo(genderLabel.snp.bottom).offset(30)
      $0.leading.equalTo(genderLabel).offset(4)
      $0.width.height.equalTo(20)
    }
    
    maleLabel.snp.makeConstraints {
      $0.top.equalTo(genderLabel.snp.bottom).offset(30)
      $0.leading.equalTo(scrollView.snp.leading).offset(44)
      $0.trailing.equalTo(genderLabel)
    }
    
    maleUnderline.snp.makeConstraints {
      $0.top.equalTo(maleRoundLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(genderLabel)
      $0.height.equalTo(1)
    }
    
    femaleRoundLabel.snp.makeConstraints {
      $0.top.equalTo(maleUnderline.snp.bottom).offset(10)
      $0.leading.equalTo(maleRoundLabel)
      $0.width.height.equalTo(20)
    }
    
    femaleLabel.snp.makeConstraints {
      $0.top.equalTo(femaleRoundLabel)
      $0.leading.trailing.equalTo(maleLabel)
    }
    
    femaleUnderline.snp.makeConstraints {
      $0.top.equalTo(femaleRoundLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(maleUnderline)
      $0.height.equalTo(1)
    }
    
    noChoiceRoundLabel.snp.makeConstraints {
      $0.top.equalTo(femaleUnderline.snp.bottom).offset(10)
      $0.leading.equalTo(femaleRoundLabel)
      $0.width.height.equalTo(20)
    }
    
    noChoiceLabel.snp.makeConstraints {
      $0.top.equalTo(noChoiceRoundLabel)
      $0.leading.trailing.equalTo(femaleLabel)
    }
    
    noChoiceUnderline.snp.makeConstraints {
      $0.top.equalTo(noChoiceRoundLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(femaleUnderline)
      $0.height.equalTo(1)
    }
    
    additionalConditionLabel.snp.makeConstraints {
      $0.top.equalTo(noChoiceUnderline.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(genderLabel)
    }
    additionalExplanationLabel.snp.makeConstraints {
      $0.top.equalTo(additionalConditionLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(additionalConditionLabel)
    }
    
    recoRoundLabel.snp.makeConstraints {
      $0.top.equalTo(additionalExplanationLabel.snp.bottom).offset(30)
      $0.leading.equalTo(noChoiceRoundLabel)
      $0.width.height.equalTo(20)
    }
    
    recoIDLabel.snp.makeConstraints {
      $0.top.equalTo(additionalExplanationLabel.snp.bottom).offset(30)
      $0.leading.equalTo(scrollView.snp.leading).offset(50)
      $0.trailing.equalTo(additionalExplanationLabel)
    }
    
    recoUnderline.snp.makeConstraints {
      $0.top.equalTo(recoIDLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(additionalExplanationLabel)
      $0.height.equalTo(1)
    }
    
    eventNameRoundLabel.snp.makeConstraints {
      $0.top.equalTo(recoUnderline.snp.bottom).offset(20)
      $0.leading.equalTo(recoRoundLabel)
      $0.width.height.equalTo(20)
    }
    
    eventName.snp.makeConstraints {
      $0.top.equalTo(eventNameRoundLabel)
      $0.leading.trailing.equalTo(recoIDLabel)
    }
    
    eventNameUnderline.snp.makeConstraints {
      $0.top.equalTo(eventName.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(recoUnderline)
      $0.height.equalTo(1)
    }
    
    grayView.snp.makeConstraints {
      $0.top.equalTo(eventNameUnderline.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalTo(10)
    }
    
    usingAgreement.snp.makeConstraints {
      $0.top.equalTo(grayView.snp.bottom).offset(20)
      $0.leading.equalTo(scrollView.snp.leading).offset(10)
      $0.trailing.equalTo(scrollView.snp.trailing).offset(10)
    }
    totalAgreeView.snp.makeConstraints {
      $0.top.equalTo(usingAgreement.snp.bottom).offset(20)
      $0.leading.equalTo(usingAgreement)
      $0.width.height.equalTo(20)
    }
    totalAgreeLabel.snp.makeConstraints {
      $0.top.equalTo(totalAgreeView)
      $0.leading.equalTo(totalAgreeView.snp.trailing).offset(10)
    }
    usingLawView.snp.makeConstraints {
      $0.top.equalTo(totalAgreeLabel.snp.bottom).offset(10)
      $0.leading.equalTo(totalAgreeLabel)
      $0.width.height.equalTo(20)
    }
    usingLawLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawView)
      $0.leading.equalTo(usingLawView.snp.trailing).offset(10)
    }
    usingLawEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawLabel)
      $0.leading.equalTo(usingLawLabel.snp.trailing).offset(10)
    }
    usingLawButton.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawEssentialLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }
    personalEssentialView.snp.makeConstraints {
      $0.top.equalTo(usingLawView.snp.bottom).offset(10)
      $0.leading.equalTo(usingLawView)
      $0.width.height.equalTo(20)
    }
    personalEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialView)
      $0.leading.equalTo(personalEssentialView.snp.trailing).offset(10)
    }
    personalEssentialNeedLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialLabel)
      $0.leading.equalTo(personalEssentialLabel.snp.trailing).offset(10)
    }
    personalEssentialButton.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialNeedLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }
    personalNotEssentialView.snp.makeConstraints {
      $0.top.equalTo(personalEssentialView.snp.bottom).offset(10)
      $0.leading.equalTo(personalEssentialView)
      $0.width.height.equalTo(20)
    }
    personalNotEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialView)
      $0.leading.equalTo(personalNotEssentialView.snp.trailing).offset(10)
    }
    personalNotEssentialNeedLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialLabel)
      $0.leading.equalTo(personalNotEssentialLabel.snp.trailing).offset(10)
    }
    personalNotEssentialButton.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }
    freeShippingView.snp.makeConstraints {
      $0.top.equalTo(personalNotEssentialView.snp.bottom).offset(10)
      $0.leading.equalTo(personalNotEssentialView)
      $0.width.height.equalTo(20)
    }
    freeShippingLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(freeShippingView)
      $0.leading.equalTo(freeShippingView.snp.trailing).offset(10)
    }
    freeShippingCheckLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(freeShippingLabel)
      $0.leading.equalTo(freeShippingLabel.snp.trailing).offset(10)
    }
    smsView.snp.makeConstraints {
      $0.top.equalTo(freeShippingLabel.snp.bottom).offset(10)
      $0.leading.equalTo(freeShippingLabel)
      $0.width.height.equalTo(20)
    }
    smsLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(smsView)
      $0.leading.equalTo(smsView.snp.trailing).offset(10)
    }
    emailCheckView.snp.makeConstraints {
      $0.top.bottom.equalTo(smsLabel)
       $0.leading.equalTo(smsLabel.snp.trailing).offset(50)
      $0.width.height.equalTo(20)
    }
    emailCheckLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(emailCheckView)
      $0.leading.equalTo(emailCheckView.snp.trailing).offset(10)
    }
    purchaseAdsView.snp.makeConstraints {
      $0.top.equalTo(emailCheckLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    ageView.snp.makeConstraints {
      $0.top.equalTo(purchaseAdsView.snp.bottom).offset(10)
      $0.leading.equalTo(freeShippingView)
      $0.width.height.equalTo(20)
    }
    ageLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(ageView)
      $0.leading.equalTo(ageView.snp.trailing).offset(10)
    }
    ageEssentialLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(ageLabel)
      $0.leading.equalTo(ageLabel.snp.trailing).offset(10)
    }
    signupButton.snp.makeConstraints {
      $0.top.equalTo(ageEssentialLabel.snp.bottom).offset(30)
      $0.leading.equalTo(totalAgreeView)
      $0.trailing.equalTo(personalNotEssentialButton)
    }
    lastExplainationLabel.snp.makeConstraints {
      $0.top.equalTo(signupButton.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.width.equalToSuperview().multipliedBy(0.92)
      $0.bottom.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension SignupView {
  private func putAsteriskBehind(text: String) -> NSMutableAttributedString {
    let myMutableString = NSMutableAttributedString(string: "\(text)*", attributes: nil)
    myMutableString.addAttribute(
      NSAttributedString.Key.foregroundColor,
      value: UIColor.purple, range: NSRange(location: text.count, length: 1)
    )
    return myMutableString
  }
  
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if textField == birthdayYearTextField {
      let currentText = textField.text ?? ""
      guard let stringRange = Range(range, in: currentText) else { return false }
      let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
      return updatedText.count <= 4
    } else {
      let currentText = textField.text ?? ""
      guard let stringRange = Range(range, in: currentText) else { return false }
      let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
      return updatedText.count <= 2
    }
  }
}
