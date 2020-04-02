//  SignUpViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
import UIKit
class SignUpViewController: UIViewController {
  private lazy var signupView = SignupView().then {
    $0.delegate = self
  }
  let agreement = Agreement()
  
  var essentialInfo: [Signup : Bool] = [
    .identification: false,
    .password: false,
    .passwordCheck: false,
    .name : false,
    .email: false,
    .cellphone: false,
    .usingLaw: false,
    .personalInfo: false,
    .ageLimit: false
  ]
  
  private var leftTime = 10 {
    didSet {
      signupView.setTimerInTextField(text: timeFormatted(leftTime))
    }
  }
  private var isAuthorized = true
  private var timer = Timer()
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  private func setupUI() {
    [signupView].forEach {
        self.view.addSubview($0)
    }
    
    signupView.backgroundColor = .white
    self.view.backgroundColor = .white
    let guide = self.view.safeAreaLayoutGuide
    
    signupView.snp.makeConstraints {
      $0.edges.equalTo(guide)
    }
  }
  func selectedAllButton() {
    agreement.usingLaw = true
    agreement.personalEseesntial = true
    agreement.personalNotEssential = true
    agreement.freeShipping = true
    agreement.sms = true
    agreement.emailCheck = true
    agreement.ageCheck = true
    signupView.totalAgreeButton.setStatus(true)
    signupView.usingLawButton.setStatus(true)
    signupView.personalEssentialButton.setStatus(true)
    signupView.personalNotEssentialButton.setStatus(true)
    signupView.freeShippingButton.setStatus(true)
    signupView.smsButton.setStatus(true)
    signupView.emailCheckButton.setStatus(true)
    signupView.ageCheckButton.setStatus(true)
  }
  func notSelectedAllButton() {
    agreement.usingLaw = false
    agreement.personalEseesntial = false
    agreement.personalNotEssential = false
    agreement.freeShipping = false
    agreement.sms = false
    agreement.emailCheck = false
    agreement.ageCheck = false
    signupView.totalAgreeButton.setStatus(false)
    signupView.usingLawButton.setStatus(false)
    signupView.personalEssentialButton.setStatus(false)
    signupView.personalNotEssentialButton.setStatus(false)
    signupView.freeShippingButton.setStatus(false)
    signupView.smsButton.setStatus(false)
    signupView.emailCheckButton.setStatus(false)
    signupView.ageCheckButton.setStatus(false)
  }
}

// MARK: - Action
extension SignUpViewController: SignupViewDelegate {
  func signupButtonTouched(button: UIButton) {
    print(essentialInfo.enumerated())
    
    for (_, value) in essentialInfo {
      if value == true {
        let alertController = UIAlertController(
          title: nil,
          message: "회원가입을 축하드립니다!\n당신의 일상에 컬리를 더해 보세요",
          preferredStyle: .alert
        )
        let warning = UIAlertAction(title: "확인", style: .default)
        alertController.addAction(warning)
        present(alertController, animated: true)
      } else {
        let alertController = UIAlertController(
          title: nil,
          message: "컬리를 더해 보세요",
          preferredStyle: .alert
        )
        let warning = UIAlertAction(title: "확인", style: .default) {_ in
        }
        alertController.addAction(warning)
        present(alertController, animated: true)
      }
    }
  }
  func squareButtonTouched(button: UIButton, leftButtons leftButton: [UIButton]) {
    if button == signupView.totalAgreeButton {
      agreement.total ? notSelectedAllButton() : selectedAllButton()
    } else if button == signupView.usingLawButton {
      essentialInfo[.usingLaw]?.toggle()
      agreement.usingLaw.toggle()
      signupView.usingLawButton.setStatus(agreement.usingLaw)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.personalEssentialButton {
      essentialInfo[.personalInfo]?.toggle()
      agreement.personalEseesntial.toggle()
    signupView.personalEssentialButton.setStatus(agreement.personalEseesntial)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.personalNotEssentialButton {
      agreement.personalNotEssential.toggle()
      signupView.personalNotEssentialButton.setStatus(agreement.personalNotEssential)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.freeShippingButton {
      agreement.freeShipping.toggle()
      
      signupView.freeShippingButton.setStatus(agreement.freeShipping)
      signupView.smsButton.setStatus(agreement.sms)
      signupView.emailCheckButton.setStatus(agreement.emailCheck)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.smsButton {
      agreement.sms.toggle()
      agreement.freeShipping = agreement.sms && agreement.emailCheck
      
      signupView.smsButton.setStatus(agreement.sms)
      signupView.freeShippingButton.setStatus(agreement.freeShipping)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.emailCheckButton {
      agreement.emailCheck.toggle()
      agreement.freeShipping = agreement.sms && agreement.emailCheck
      
      signupView.emailCheckButton.setStatus(agreement.emailCheck)
      signupView.freeShippingButton.setStatus(agreement.freeShipping)
      signupView.totalAgreeButton.setStatus(agreement.total)
    } else if button == signupView.ageCheckButton {
      agreement.ageCheck.toggle()
      essentialInfo[.ageLimit]?.toggle()
      signupView.ageCheckButton.setStatus(agreement.ageCheck)
      signupView.totalAgreeButton.setStatus(agreement.total)
    }
  }
  func recoAndEventRoundButtonTouched(button: UIButton, eventButton: [UIButton]) {
    let borderWidth: CGFloat = 6
    button.layer.borderColor = UIColor.kurlyPurple.cgColor
    button.layer.borderWidth = borderWidth
    eventButton.forEach {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.lightGray.cgColor
    }
  }
  func genderRoundButtonTouched(button: UIButton, noChoice: [UIButton]) {
    let borderWidth: CGFloat = 6
    button.layer.borderColor = UIColor.kurlyPurple.cgColor
    button.layer.borderWidth = borderWidth
    noChoice.forEach {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.lightGray.cgColor
    }
  }  
  func checkingCodeButtonTouched() {
    if signupView.getCheckingCodeTexField() == "000000" {
      signupView.activateCheckingCodeTexField(false)
      signupView.activateCheckingCodeButton(false)
      signupView.checkingCodeCompleteLabelOpenHiddenMessage(text: "인증번호 확인완료.", textColor: .green)
      signupView.activateGetCodeButton(false)
      isAuthorized = false
      self.signupView.hideTimerInTextField(true)
      essentialInfo[.cellphone] = true
    } else {
      signupView.checkingCodeCompleteLabelOpenHiddenMessage(text: "인증번호를 확인해주세요", textColor: .orange)
      essentialInfo[.cellphone] = false
    }
  }
  func receivingCellphoneNumberButtonTouched() {
    let text = signupView.getCellphoneTextField()
    if hasCellphoneNumber(text: text) {
      signupView.hideTimerInTextField(false)
      signupView.activateGetCodeButton(false)
      signupView.setCheckingCodeButton(buttonColor: .kurlyPurple)
      startTimer()
      signupView.setGetCodeButton(buttonColor: .lightGray)
      signupView.activateCellphoneTextField(false)
    } else {
      let alertController = UIAlertController(
        title: nil,
        message: "잘못된 휴대폰 번호 입니다. 확인후 다시 시도 해 주세요",
        preferredStyle: .alert
      )
      let warning = UIAlertAction(title: "확인", style: .default) { _ in
      }
      alertController.addAction(warning)
      present(alertController, animated: true)
    }
  }
  func startTimer() {
      timer = Timer.scheduledTimer(
        timeInterval: 1,
        target: self,
        selector: #selector(update),
        userInfo: nil, repeats: true
    )
  }
  @objc func update() {
    leftTime -= 1
    
    if leftTime == 0 && isAuthorized {
      endTimer()
      let alertController = UIAlertController(
        title: nil,
        message: "인증 제한 시간이 지났습니다",
        preferredStyle: .alert
      )
      let warning = UIAlertAction(title: "확인", style: .default) { _ in
        self.signupView.hideTimerInTextField(true)
        self.signupView.setCheckingCodeButton(buttonColor: .lightGray)
        self.signupView.setGetCodeButton(buttonColor: .kurlyPurple)
        self.signupView.activateGetCodeButton(true)
        self.leftTime = 5
        self.signupView.activateCellphoneTextField(true)
      }
      alertController.addAction(warning)
      present(alertController, animated: true)
    }
  }
  func timeFormatted(_ totalSeconds: Int) -> String {
      let seconds: Int = totalSeconds % 60
      let minutes: Int = (totalSeconds / 60) % 60
      //     let hours: Int = totalSeconds / 3600
      return String(format: "%02d:%02d", minutes, seconds)
  }
  func endTimer() {
      timer.invalidate()
  }
  func emailTextFeildEditingChanged(_ textField: UITextField, text: String) {
    if isEmail(email: text) {
      textField.layer.borderColor = UIColor.green.cgColor
      essentialInfo[.email] = true
    } else {
      textField.layer.borderColor = UIColor.orange.cgColor
      essentialInfo[.email] = false
    }
  }
  func cellphoneTextFieldEditingChanged(_ textField: UITextField, text: String) {
    if text.count > 9 {
      signupView.setGetCodeButton(buttonColor: .kurlyPurple)
      signupView.enableReceivingCellphoneNumberButton(true)
    } else {
      signupView.setGetCodeButton(buttonColor: .gray)
      signupView.enableReceivingCellphoneNumberButton(false)
    }
  }
  private func hasCellphoneNumber(text: String) -> Bool {
      do {
        let regex = try NSRegularExpression(
          pattern: "^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$",
          options: .caseInsensitive
        )
        if regex.firstMatch(
          in: text,
          options: NSRegularExpression.MatchingOptions.reportCompletion,
          range: NSRange(location: 0, length: text.count)) != nil {
              return true
          }
      } catch {
          print(error.localizedDescription)
          return false
      }
      return false
  }
  func validateEmail() -> Bool {
      let emailRegEx = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
      let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
      return predicate.evaluate(with: self)
  }
  func checkName(_ textField: UITextField, text: String) {
    if text.count >= 1 {
      essentialInfo[.name] = true
    } else {
      essentialInfo[.name] = false
    }
  }
  func checkSecretNumberTextFeildEditingChanged(_ textField: UITextField, text: String) {
    print("checkSecretNumberTextFeildEditingChanged")
    if text == signupView.getSecretTextFieldText() {
      signupView.setSameSecretNumberLabel(textColor: .green)
        essentialInfo[.passwordCheck] = true
    } else {
      signupView.setSameSecretNumberLabel(textColor: .orange)
       essentialInfo[.passwordCheck] = false
    }
  }
  func secretTextFeildEditingChanged(_ textField: UITextField, text: String) {
    if text.count >= 10 &&
      hasSpecialWords(text: text) &&
      !checkContinuousNumber(text) {
      essentialInfo[.password] = true
    } else {
      essentialInfo[.password] = false
    }
    
    if text.count >= 10 {
      signupView.setTenSyllableLabel(textColor: .green)
    } else {
      signupView.setTenSyllableLabel(textColor: .orange)
    }

     if hasSpecialWords(text: text) {
      signupView.setCombinationLabel(textColor: .green)
     } else {
      signupView.setCombinationLabel(textColor: .orange)
    }
    
    let isContinuous = checkContinuousNumber(text)
    
    if !isContinuous {
      signupView.setnotSameTheeNumberLabel(textColor: .green)
    } else {
      signupView.setnotSameTheeNumberLabel(textColor: .orange)
    }
    if text == signupView.getCheckSecretNumberTextFeild() {
      print("1")
      print(text)
      signupView.setSameSecretNumberLabel(textColor: .green)
    } else {
      print("2")
      print(text)
      print(signupView.getCheckingCodeTexField())
      signupView.setSameSecretNumberLabel(textColor: .orange)
    }
  }
  
  func checkWidth(_ text: String) -> Bool {
    return text.count > 9
  }
  func checkContinuousNumber(_ text: String) -> Bool {
    let continuousSet = Array(0...9).map { "\($0)\($0)\($0)" }
    var isContinuous = false
    continuousSet.forEach {
      if text.contains($0) {
        isContinuous = true
        return
      }
    }
    return isContinuous
  }
  func checkIDButtonTouched(_ button: UIButton) {
    let text = signupView.getIDTextFieldText()
    if text.count >= 6 && hasOnlyAlphabetAndNumber(text: text) {
      print("Correct")
      signupView.setCheckingIdLabel(.green)
      essentialInfo[.identification] = true
      print(essentialInfo[.identification])
    } else {
      signupView.setCheckingIdLabel(.orange)
      essentialInfo[.identification] = false
      let alertController = UIAlertController(
        title: nil,
        message: "6자 이상의 영문 혹은 영문과 숫자를 조합으로 입력해 주세요",
        preferredStyle: .alert
      )
      let warning = UIAlertAction(title: "확인", style: .default) { _ in
      }
      alertController.addAction(warning)
      present(alertController, animated: true)
    }
  }
  private func isEmail (email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
  }
  private func hasOnlyAlphabetAndNumber(text: String) -> Bool {
      do {
        let regex = try NSRegularExpression(
          pattern: "^(?!(?:[0-9]+)$)([a-zA-Z]|[0-9a-zA-Z]){4,}$",
          options: .caseInsensitive)
        if regex.firstMatch(
          in: text,
          options: NSRegularExpression.MatchingOptions.reportCompletion,
          range: NSRange(location: 0, length: text.count)) != nil {
              return true
          }
      } catch {
          print(error.localizedDescription)
          return false
      }
      return false
  }
  private func hasSpecialWords(text: String) -> Bool {
      do {
        let regex = try NSRegularExpression(
          pattern: "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{10,16}$",
          options: .caseInsensitive)
        if regex.firstMatch(
          in: text,
          options: NSRegularExpression.MatchingOptions.reportCompletion,
          range: NSRange(location: 0, length: text.count)) != nil {
              return true
          }
      } catch {
          print(error.localizedDescription)
          return false
      }
      return false
  }
  func idTextFieldEditingChanged(_ textField: UITextField, text: String) {
    if text.count >= 6 && hasOnlyAlphabetAndNumber(text: text) {
      signupView.setIDLimitExplanationLabel(textColor: .green)
    } else {
      signupView.setIDLimitExplanationLabel(textColor: .orange)
    }
  }
  func checkSecretNumberTextFeildDidBeginEditing(_ textField: UITextField) {
    signupView.checkSecretNumberTextFeildOpenHiddenMessage()
  }
  func secretTextFeildDidBeginEditing(_ textField: UITextField) {
    signupView.secretTextFeildOpenHiddenMessage()
  }
  func idTextFieldDidBeginEditing(_ textField: UITextField) {
    signupView.idTextFieldOpenHiddenMessage()
  }
  func idTextField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 12
  }
  func secretTextField(_ textField: UITextField,
                       shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 16
  }
  func checkSecretNumberTextField(_ textField: UITextField,
                                  shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 12
  }
  func nameTextField(_ textField: UITextField,
                     shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 12
  }
  func emailTextField(_ textField: UITextField,
                      shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 30
  }
  func cellphoneTextField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 13
  }
  func checkingReceivingNumberTextField(_ textField: UITextField,
                                        shouldChangeCharactersIn range: NSRange,
                                        replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 6
  }
  
  func birthdayYearTextField(_ textField: UITextField,
                             shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 4
  }
  
  func birthdayMonthTextField(_ textField: UITextField,
                              shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 2
  }
  
  func birthdayDayTextField(_ textField: UITextField,
                            shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let currentText = textField.text ?? ""
    guard let stringRange = Range(range, in: currentText) else { return false }
    let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
    return updatedText.count <= 2
  }
}
