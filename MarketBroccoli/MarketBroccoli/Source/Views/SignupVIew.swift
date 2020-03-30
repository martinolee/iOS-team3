//
//  testUIView.swift
//  20200112ScrollViewPractice
//
//  Created by macbook on 2020/03/23.
//  Copyright © 2020 Lance. All rights reserved.
//

import UIKit

protocol SignupViewDelegate: class {
  func idTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func secretTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func checkSecretNumberTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func nameTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func emailTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func cellphoneTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func checkingReceivingNumberTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func birthdayYearTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func birthdayMonthTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func birthdayDayTextField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool
  func idTextFieldDidBeginEditing(_ textField: UITextField)
  func secretTextFeildDidBeginEditing(_ textField: UITextField)
  func checkSecretNumberTextFeildDidBeginEditing(_ textField: UITextField)
  func idTextFieldEditingChanged(_ textField: UITextField, text: String)
  func checkIDButtonTouched(_ button: UIButton)
  func secretTextFeildEditingChanged(_ textField: UITextField, text: String)
  func checkSecretNumberTextFeildEditingChanged(_ textField: UITextField, text: String)
  func emailTextFeildEditingChanged(_ textField: UITextField, text: String)
  func cellphoneTextFieldEditingChanged(_ textField: UITextField, text: String)
  func receivingCellphoneNumberButtonTouched()
  func checkingCodeButtonTouched()
  func genderRoundButtonTouched(button: UIButton, noChoice: [UIButton])
  func recoAndEventRoundButtonTouched(button: UIButton, eventButton: [UIButton])
}
class SignupView: UIView, UITextFieldDelegate {
  weak var delegate: SignupViewDelegate?
  private lazy var idLabel = UILabel().then {
    let text = putAsteriskBehind(text: "아이디")
    $0.attributedText = text
  }
  private lazy var idTextFeild = UITextField().then {
    $0.placeholder = "예: marketkurly12"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
    $0.delegate = self
    $0.addTarget(self, action: #selector(idTextFieldEditingChanged), for: .editingChanged)
  }
  private let checkIDButton = UIButton().then {
    $0.setTitle("중복확인", for: .normal)
    $0.backgroundColor = .kurlyPurple
    $0.setTitleColor(.white, for: .normal)
    $0.addTarget(self, action: #selector(checkIDButtonTouched), for: .touchUpInside)
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
  private lazy var secretTextFeild = UITextField().then {
    $0.placeholder = "비밀번호를 입력해주세요"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
    $0.delegate = self
    $0.addTarget(self, action: #selector(secretTextFeildEditingChanged), for: .editingChanged)
  }
  private let tenSyllableLabel = UILabel().then {
    $0.text = "10자 이상 입력"
    $0.textColor = .lightGray
    $0.font = .systemFont(ofSize: 10)
  }
  private let combinationLabel = UILabel().then {
    $0.text = "영문/숫자/공백제외만 허용하며, 2개 이상 조합"
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
  private lazy var checkSecretNumberTextFeild = UITextField().then {
    $0.placeholder = "비밀번호를 한번 더 입력해주세요"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
    $0.delegate = self
    $0.addTarget(self, action: #selector(checkSecretNumberTextFeildEditingChanged), for: .editingChanged)
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
  private lazy var emailLabel = UILabel().then {
    let text = putAsteriskBehind(text: "이메일")
    $0.attributedText = text
  }
  private lazy var emailTextFeild = UITextField().then { $0.placeholder = "예: marketkurly@kurly.com"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
    $0.delegate = self
    $0.addTarget(self, action: #selector(emailTextFeildEditingChanged), for: .editingChanged)
  }
  private lazy var cellphoneLabel = UILabel().then {
    let text = putAsteriskBehind(text: "휴대폰")
    $0.attributedText = text
  }
  private lazy var cellphoneTextField = UITextField().then {
    $0.placeholder = "'-' 없이 숫자만"
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
    $0.delegate = self
    $0.addTarget(self, action: #selector(cellphoneTextFieldEditingChanged), for: .editingChanged)
  }
  private lazy var getCodeButton = UIButton().then {
    $0.setTitle("인증번호 받기", for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .gray
    $0.addTarget(self, action: #selector(getCodeButtonTouched), for: .touchUpInside)
  }
  private lazy var checkingCodeTexField = UITextField().then {
    $0.placeholder = ""
    $0.borderStyle = .roundedRect
    $0.clearButtonMode = .whileEditing
    $0.delegate = self
  }
  private let timerInTextField = UILabel().then {
    $0.textColor = .orange
    $0.isHidden = true
  }
  
  private let checkingCodeButton = UIButton().then {
    $0.setTitle("인증번호 확인", for: .normal)
    $0.setTitleColor(.gray, for: .normal)
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.backgroundColor = .white
    $0.addTarget(self, action: #selector(checkingCodeButtonTouched), for: .touchUpInside)
  }
  private var checkingCodeCompleteLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 10)
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
    $0.backgroundColor = .kurlyPurple
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
  private lazy var maleRoundButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.addTarget(self, action: #selector(genderRoundButtonTouched), for: .touchUpInside)
  }
  private let maleLabel = UILabel().then {
    $0.text = "남자"
  }
  private let maleUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let femaleRoundButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.addTarget(self, action: #selector(genderRoundButtonTouched), for: .touchUpInside)
  }
  private let femaleLabel = UILabel().then {
    $0.text = "여자"
  }
  private let femaleUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let noChoiceRoundButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.addTarget(self, action: #selector(genderRoundButtonTouched), for: .touchUpInside)
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
  private let recoRoundButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.addTarget(self, action: #selector(recoAndEventRoundButtonTouched), for: .touchUpInside)
  }
  private let recoIDLabel = UILabel().then {
    $0.text = "추천인 아이디"
  }
  private let recoUnderline = UIView().then {
    $0.layer.borderWidth = 0.2
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let eventNameRoundButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
    $0.addTarget(self, action: #selector(recoAndEventRoundButtonTouched), for: .touchUpInside)
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
  private let totalAgreeButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let totalAgreeLabel = UILabel().then {
    $0.text = "전체동의"
  }
  private let usingLawButton = UIButton().then {
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
  private let usingLawSeeButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.kurlyPurple, for: .normal)
  }
  private let personalEssentialButton = UIButton().then {
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
  private let personalEssentialSeeButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.kurlyPurple, for: .normal)
  }
  private let personalNotEssentialButton = UIButton().then {
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
  private let personalNotEssentialSeeButton = UIButton().then {
    $0.setTitle("약관보기 >", for: .normal)
    $0.setTitleColor(.kurlyPurple, for: .normal)
  }
  private let freeShippingButton = UIButton().then {
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
  private let smsButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let smsLabel = UILabel().then {
    $0.text = "SMS"
  }
  private let emailCheckButton = UIButton().then {
    $0.layer.borderWidth = 1
    $0.layer.borderColor = UIColor.lightGray.cgColor
  }
  private let emailCheckLabel = UILabel().then {
    $0.text = "이메일"
  }
  private let purchaseAdsView = UIImageView().then {
    $0.image = UIImage(named: "구매혜택")
  }
  private let ageCheckButton = UIButton().then {
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
    $0.backgroundColor = .kurlyPurple
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
    makeRoundCorner(button: femaleRoundButton)
    makeRoundCorner(button: maleRoundButton)
    makeRoundCorner(button: noChoiceRoundButton)
    makeRoundCorner(button: recoRoundButton)
    makeRoundCorner(button: eventNameRoundButton)
  }
  private func makeRoundCorner(button: UIButton) {
    button.layer.masksToBounds = true
    button.layer.cornerRadius = button.bounds.height / 2
  }
  private func setupUI() {
    [idLabel, idTextFeild, checkIDButton,
     secretNumberLabel, secretTextFeild, checkSecretNumberLabel,
     checkSecretNumberTextFeild, nameLabel, nameTextFeild,
     emailLabel, emailTextFeild, cellphoneLabel,
     cellphoneTextField, getCodeButton, checkingCodeCompleteLabel,
     checkingCodeTexField, timerInTextField, checkingCodeButton,
     addressLabel, addressCheckingLabel, searchingAddressButton,
     birthdayLabel, genderLabel, maleRoundButton, maleLabel,
     bunchBirthdayView, femaleRoundButton, noChoiceRoundButton,
     recoRoundButton, eventNameRoundButton, recoUnderline, eventNameUnderline,
     maleUnderline, femaleUnderline, noChoiceUnderline,
     femaleLabel, noChoiceLabel, additionalConditionLabel,
     additionalExplanationLabel, recoIDLabel, eventName, grayView,
     usingAgreement, totalAgreeButton, totalAgreeLabel, usingLawButton, usingLawLabel, sameSecretNumberLabel,
     usingLawEssentialLabel, usingLawSeeButton, personalEssentialButton, personalEssentialLabel,
     tenSyllableLabel, combinationLabel, notSameTheeNumber,
     personalEssentialNeedLabel, personalEssentialSeeButton, personalNotEssentialButton, personalNotEssentialLabel,
     personalNotEssentialNeedLabel, personalNotEssentialSeeButton, freeShippingButton, freeShippingLabel,
     freeShippingCheckLabel, smsButton, smsLabel, emailCheckButton, emailCheckLabel,
     purchaseAdsView, ageCheckButton, ageLabel, ageEssentialLabel,
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
      $0.height.equalTo(0)
    }
    checkingIdLabel.snp.makeConstraints {
      $0.top.equalTo(idLimitExplanationLabel.snp.bottom).offset(4)
      $0.leading.equalTo(idLimitExplanationLabel)
      $0.trailing.equalTo(idLimitExplanationLabel)
      $0.height.equalTo(0)
    }
    secretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(checkingIdLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(checkingIdLabel)
    }
    secretTextFeild.snp.makeConstraints {
      $0.top.equalTo(secretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(secretNumberLabel)
    }
    tenSyllableLabel.snp.makeConstraints {
      $0.top.equalTo(secretTextFeild.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(secretNumberLabel)
      $0.height.equalTo(0)
    }
    combinationLabel.snp.makeConstraints {
      $0.top.equalTo(tenSyllableLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(tenSyllableLabel)
      $0.height.equalTo(0)
    }
    notSameTheeNumber.snp.makeConstraints {
      $0.top.equalTo(combinationLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(combinationLabel)
      $0.height.equalTo(0)
    }
    checkSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(notSameTheeNumber.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(notSameTheeNumber)
    }
    checkSecretNumberTextFeild.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(checkSecretNumberLabel)
    }
    sameSecretNumberLabel.snp.makeConstraints {
      $0.top.equalTo(checkSecretNumberTextFeild.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(checkSecretNumberTextFeild)
      $0.height.equalTo(0)
    }
    nameLabel.snp.makeConstraints {
      $0.top.equalTo(sameSecretNumberLabel.snp.bottom).offset(10)
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
    getCodeButton.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField)
      $0.leading.equalTo(cellphoneTextField.snp.trailing).offset(10)
      $0.trailing.equalTo(cellphoneLabel)
    }
    checkingCodeTexField.snp.makeConstraints {
      $0.top.equalTo(cellphoneTextField.snp.bottom).offset(10)
      $0.leading.equalTo(cellphoneTextField)
      $0.width.equalTo(scrollView.snp.width).multipliedBy(0.5)
    }
    timerInTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(checkingCodeTexField)
      $0.trailing.equalTo(checkingCodeTexField.snp.trailing).offset(-10)
    }
    
    checkingCodeButton.snp.makeConstraints {
      $0.top.equalTo(getCodeButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(getCodeButton)
    }
    checkingCodeCompleteLabel.snp.makeConstraints {
      $0.top.equalTo(checkingCodeTexField.snp.bottom).offset(10)
      $0.leading.equalTo(checkingCodeTexField)
      $0.height.equalTo(0)
    }
    addressLabel.snp.makeConstraints {
      $0.top.equalTo(checkingCodeCompleteLabel.snp.bottom).offset(20)
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
      $0.height.equalTo(checkingCodeTexField)
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
    maleRoundButton.snp.makeConstraints {
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
      $0.top.equalTo(maleRoundButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(genderLabel)
      $0.height.equalTo(1)
    }
    femaleRoundButton.snp.makeConstraints {
      $0.top.equalTo(maleUnderline.snp.bottom).offset(10)
      $0.leading.equalTo(maleRoundButton)
      $0.width.height.equalTo(20)
    }
    femaleLabel.snp.makeConstraints {
      $0.top.equalTo(femaleRoundButton)
      $0.leading.trailing.equalTo(maleLabel)
    }
    femaleUnderline.snp.makeConstraints {
      $0.top.equalTo(femaleRoundButton.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(maleUnderline)
      $0.height.equalTo(1)
    }
    noChoiceRoundButton.snp.makeConstraints {
      $0.top.equalTo(femaleUnderline.snp.bottom).offset(10)
      $0.leading.equalTo(femaleRoundButton)
      $0.width.height.equalTo(20)
    }
    noChoiceLabel.snp.makeConstraints {
      $0.top.equalTo(noChoiceRoundButton)
      $0.leading.trailing.equalTo(femaleLabel)
    }
    noChoiceUnderline.snp.makeConstraints {
      $0.top.equalTo(noChoiceRoundButton.snp.bottom).offset(10)
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
    recoRoundButton.snp.makeConstraints {
      $0.top.equalTo(additionalExplanationLabel.snp.bottom).offset(30)
      $0.leading.equalTo(noChoiceRoundButton)
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
    eventNameRoundButton.snp.makeConstraints {
      $0.top.equalTo(recoUnderline.snp.bottom).offset(20)
      $0.leading.equalTo(recoRoundButton)
      $0.width.height.equalTo(20)
    }
    eventName.snp.makeConstraints {
      $0.top.equalTo(eventNameRoundButton)
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
    totalAgreeButton.snp.makeConstraints {
      $0.top.equalTo(usingAgreement.snp.bottom).offset(20)
      $0.leading.equalTo(usingAgreement)
      $0.width.height.equalTo(20)
    }
    totalAgreeLabel.snp.makeConstraints {
      $0.top.equalTo(totalAgreeButton)
      $0.leading.equalTo(totalAgreeButton.snp.trailing).offset(10)
    }
    usingLawButton.snp.makeConstraints {
      $0.top.equalTo(totalAgreeLabel.snp.bottom).offset(10)
      $0.leading.equalTo(totalAgreeLabel)
      $0.width.height.equalTo(20)
    }
    usingLawLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawButton)
      $0.leading.equalTo(usingLawButton.snp.trailing).offset(10)
    }
    usingLawEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawLabel)
      $0.leading.equalTo(usingLawLabel.snp.trailing).offset(10)
    }
    usingLawSeeButton.snp.makeConstraints {
      $0.top.bottom.equalTo(usingLawEssentialLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }
    personalEssentialButton.snp.makeConstraints {
      $0.top.equalTo(usingLawButton.snp.bottom).offset(10)
      $0.leading.equalTo(usingLawButton)
      $0.width.height.equalTo(20)
    }
    personalEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialButton)
      $0.leading.equalTo(personalEssentialButton.snp.trailing).offset(10)
    }
    personalEssentialNeedLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialLabel)
      $0.leading.equalTo(personalEssentialLabel.snp.trailing).offset(10)
    }
    personalEssentialSeeButton.snp.makeConstraints {
      $0.top.bottom.equalTo(personalEssentialNeedLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }
    personalNotEssentialButton.snp.makeConstraints {
      $0.top.equalTo(personalEssentialButton.snp.bottom).offset(10)
      $0.leading.equalTo(personalEssentialButton)
      $0.width.height.equalTo(20)
    }
    personalNotEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialButton)
      $0.leading.equalTo(personalNotEssentialButton.snp.trailing).offset(10)
    }
    personalNotEssentialNeedLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialLabel)
      $0.leading.equalTo(personalNotEssentialLabel.snp.trailing).offset(10)
    }
    personalNotEssentialSeeButton.snp.makeConstraints {
      $0.top.bottom.equalTo(personalNotEssentialLabel)
      $0.trailing.equalToSuperview().offset(-20)
    }
    freeShippingButton.snp.makeConstraints {
      $0.top.equalTo(personalNotEssentialButton.snp.bottom).offset(10)
      $0.leading.equalTo(personalNotEssentialButton)
      $0.width.height.equalTo(20)
    }
    freeShippingLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(freeShippingButton)
      $0.leading.equalTo(freeShippingButton.snp.trailing).offset(10)
    }
    freeShippingCheckLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(freeShippingLabel)
      $0.leading.equalTo(freeShippingLabel.snp.trailing).offset(10)
    }
    smsButton.snp.makeConstraints {
      $0.top.equalTo(freeShippingLabel.snp.bottom).offset(10)
      $0.leading.equalTo(freeShippingLabel)
      $0.width.height.equalTo(20)
    }
    smsLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(smsButton)
      $0.leading.equalTo(smsButton.snp.trailing).offset(10)
    }
    emailCheckButton.snp.makeConstraints {
      $0.top.bottom.equalTo(smsLabel)
       $0.leading.equalTo(smsLabel.snp.trailing).offset(50)
      $0.width.height.equalTo(20)
    }
    emailCheckLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(emailCheckButton)
      $0.leading.equalTo(emailCheckButton.snp.trailing).offset(10)
    }
    purchaseAdsView.snp.makeConstraints {
      $0.top.equalTo(emailCheckLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    ageCheckButton.snp.makeConstraints {
      $0.top.equalTo(purchaseAdsView.snp.bottom).offset(10)
      $0.leading.equalTo(freeShippingButton)
      $0.width.height.equalTo(20)
    }
    ageLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(ageCheckButton)
      $0.leading.equalTo(ageCheckButton.snp.trailing).offset(10)
    }
    ageEssentialLabel.snp.makeConstraints {
      $0.top.bottom.equalTo(ageLabel)
      $0.leading.equalTo(ageLabel.snp.trailing).offset(10)
    }
    signupButton.snp.makeConstraints {
      $0.top.equalTo(ageEssentialLabel.snp.bottom).offset(30)
      $0.leading.equalTo(totalAgreeButton)
      $0.trailing.equalTo(personalNotEssentialSeeButton)
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
      value: UIColor.kurlyPurple, range: NSRange(location: text.count, length: 1)
    )
    return myMutableString
  }
  func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    guard let delegate = delegate else { fatalError() }
    
    switch textField {
    case idTextFeild:
      return delegate.idTextField(textField, shouldChangeCharactersIn: range, replacementString: string)
    case secretTextFeild:
      return delegate.secretTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case checkSecretNumberTextFeild:
      return delegate.checkSecretNumberTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case nameTextFeild:
      return delegate.nameTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string)
    case emailTextFeild:
      return delegate.emailTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case cellphoneTextField:
      return delegate.cellphoneTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case checkingCodeTexField:
      return delegate.checkingReceivingNumberTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case birthdayYearTextField:
      return delegate.birthdayYearTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case birthdayMonthTextField:
      return delegate.birthdayMonthTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    case birthdayDayTextField:
      return delegate.birthdayDayTextField(
        textField,
        shouldChangeCharactersIn: range,
        replacementString: string
      )
    default:
      fatalError()
    }
  }
  func textFieldDidBeginEditing(_ textField: UITextField) {
    guard let delegate = delegate else { fatalError() }
    switch textField {
    case idTextFeild:
      return delegate.idTextFieldDidBeginEditing(textField)
    case secretTextFeild:
      return delegate.secretTextFeildDidBeginEditing(textField)
    case checkSecretNumberTextFeild:
      return delegate.checkSecretNumberTextFeildDidBeginEditing(textField)
    default:
      return print("")
    }
  }
  func idTextFieldOpenHiddenMessage() {
    idLimitExplanationLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    checkingIdLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    secretNumberLabel.snp.updateConstraints {
      $0.top.equalTo(checkingIdLabel.snp.bottom).offset(30)
    }
  }
  func secretTextFeildOpenHiddenMessage() {
    tenSyllableLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    combinationLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    notSameTheeNumber.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    checkSecretNumberLabel.snp.updateConstraints {
      $0.top.equalTo(notSameTheeNumber.snp.bottom).offset(30)
    }
  }
  func checkSecretNumberTextFeildOpenHiddenMessage() {
    sameSecretNumberLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    nameLabel.snp.updateConstraints {
      $0.top.equalTo(sameSecretNumberLabel.snp.bottom).offset(30)
    }
  }
  func checkingCodeCompleteLabelOpenHiddenMessage(text: String, textColor: UIColor) {
    checkingCodeCompleteLabel.text = text
    checkingCodeCompleteLabel.textColor = textColor
    checkingCodeCompleteLabel.snp.updateConstraints {
      $0.height.equalTo(10)
    }
    addressLabel.snp.updateConstraints {
      $0.top.equalTo(checkingCodeCompleteLabel.snp.bottom).offset(30)
    }
  }
  @objc func idTextFieldEditingChanged(_ textField: UITextField) {
    guard
      let delegate = delegate,
      let text = textField.text
    else { fatalError() }
    
    delegate.idTextFieldEditingChanged(textField, text: text)
  }
  func setIDLimitExplanationLabel(textColor: UIColor) {
    idLimitExplanationLabel.textColor = textColor
  }
  @objc func checkIDButtonTouched(_ button: UIButton) {
    delegate?.checkIDButtonTouched(button)
  }
  func getIDTextFieldText() -> String {
    idTextFeild.text ?? ""
  }
  @objc func secretTextFeildEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
    else { fatalError() }
    delegate.secretTextFeildEditingChanged(textField, text: text)
  }
  func setTenSyllableLabel(textColor: UIColor) {
    tenSyllableLabel.textColor = textColor
  }
  func getSecretTextFeildText() -> String {
    secretTextFeild.text ?? ""
  }
  func setCombinationLabel(textColor: UIColor) {
    combinationLabel.textColor = textColor
  }
  func setnotSameTheeNumberLabel(textColor: UIColor) {
    notSameTheeNumber.textColor = textColor
  }
  @objc func checkSecretNumberTextFeildEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
    else { fatalError() }
    delegate.checkSecretNumberTextFeildEditingChanged(textField, text: text)
  }
  func setSameSecretNumberLabel(textColor: UIColor) {
    sameSecretNumberLabel.textColor = textColor
  }
  @objc func cellphoneTextFieldEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
    else { fatalError() }
    delegate.cellphoneTextFieldEditingChanged(textField, text: text)
  }
  func setGetCodeButton(buttonColor: UIColor) {
    getCodeButton.backgroundColor = buttonColor
  }
  func enableReceivingCellphoneNumberButton(_ enable: Bool) {
    getCodeButton.isEnabled = enable
  }
  @objc func emailTextFeildEditingChanged(_ textField: UITextField, text: String) {
    guard
      let delegate = delegate,
      let text = textField.text
    else { fatalError() }
    delegate.emailTextFeildEditingChanged(textField, text: text)
  }
  
  @objc func getCodeButtonTouched() {
    delegate?.receivingCellphoneNumberButtonTouched()
  }
  func setTimerInTextField(text: String) {
    timerInTextField.text = text
  }
  func getCellphoneTextField() -> String {
    cellphoneTextField.text ?? ""
  }
  func hideTimerInTextField(_ hidden: Bool) {
    timerInTextField.isHidden = hidden
  }
  func activateGetCodeButton(_ able: Bool) {
    getCodeButton.isEnabled = able
    able ? (getCodeButton.backgroundColor = .kurlyPurple) : (getCodeButton.backgroundColor = .lightGray)
  }
  func setCheckingCodeButton(buttonColor: UIColor) {
    checkingCodeButton.layer.borderColor = buttonColor.cgColor
    checkingCodeButton.setTitleColor(buttonColor, for: .normal)
  }
   func activateCellphoneTextField(_ able: Bool) {
    cellphoneTextField.isEnabled = able
  }
  func getCheckingCodeTexField() -> String {
    checkingCodeTexField.text ?? ""
  }
  @objc func checkingCodeButtonTouched() {
    delegate?.checkingCodeButtonTouched()
  }
  func activateCheckingCodeTexField(_ able: Bool) {
   checkingCodeTexField.isEnabled = able
  }
  func activateCheckingCodeButton(_ able: Bool) {
  checkingCodeButton.isEnabled = able
  }
  @objc func genderRoundButtonTouched(button: UIButton) {
    let buttons = [maleRoundButton, femaleRoundButton, noChoiceRoundButton]
      .filter { $0 != button }
    delegate?.genderRoundButtonTouched(button: button, noChoice: buttons)
  }
  @objc func recoAndEventRoundButtonTouched(button: UIButton) {
    let buttons = [recoRoundButton, eventNameRoundButton]
      .filter { $0 != button }
    delegate?.recoAndEventRoundButtonTouched(button: button, eventButton: buttons)
    
  }
  
  
}
