//
//  SignUpViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//
import UIKit

class SignUpViewController: UIViewController {
  private lazy var signupView = SignupView().then {
    $0.delegate = self
  }
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
}

// MARK: - Action
extension SignUpViewController: SignupViewDelegate {
  func recoAndEventRoundButtonTouched(button: UIButton, eventButton: [UIButton]) {
    let borderWidth: CGFloat = 6
    button.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
    button.layer.borderColor = UIColor.kurlyPurple.cgColor
    button.layer.borderWidth = borderWidth
    
    eventButton.forEach {
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.lightGray.cgColor
    }
  }
  func genderRoundButtonTouched(button: UIButton, noChoice: [UIButton]) {
    let borderWidth: CGFloat = 6
    button.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
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
    } else {
      signupView.checkingCodeCompleteLabelOpenHiddenMessage(text: "인증번호를 확인해주세요", textColor: .orange)
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
    
    if leftTime == 0 && isAuthorized{
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
      print("correct")
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
  func checkSecretNumberTextFeildEditingChanged(_ textField: UITextField, text: String) {
    print("checkSecretNumberTextFeildEditingChanged")
    if text == signupView.getSecretTextFeildText() {
      signupView.setSameSecretNumberLabel(textColor: .green)
    } else {
      signupView.setSameSecretNumberLabel(textColor: .orange)
    }
  }
  
  func secretTextFeildEditingChanged(_ textField: UITextField, text: String) {
    print("secretTextFeildEditingChanged")
    
    if text.count <= 9 || hasOnlyAlphabetAndNumber(text: text) {
      signupView.setTenSyllableLabel(textColor: .orange)
    } else {
      signupView.setTenSyllableLabel(textColor: .green)
    }
//
     if hasSpecialWords(text: text) {
      signupView.setCombinationLabel(textColor: .green)
     } else {
      signupView.setCombinationLabel(textColor: .orange)
    }
    
    let isContinuous = checkContinuousNumber(text)
    print(isContinuous)
    if !checkContinuousNumber(text) {
      signupView.setnotSameTheeNumberLabel(textColor: .green)
    } else {
      signupView.setnotSameTheeNumberLabel(textColor: .orange)
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
//  func checkAlphabet(_ ascii: String.UTF16View.Element) -> Bool {
//    if (65...90).contains(ascii) || (97...122).contains(ascii) {
//      return true
//    } else {
//      return false
//    }
//  }
//
//  func checkNumber(_ ascii: String.UTF16View.Element) -> Bool {
//    if (48...57).contains(ascii) {
//      return true
//    } else {
//      return false
//    }
//  }
//
//  func checkSpecialCharacter(_ ascii: String.UTF16View.Element) -> Bool {
//    if (33...47).contains(ascii) {
//      return true
//    } else {
//      return false
//    }
//  }
  func checkIDButtonTouched(_ button: UIButton) {
    let text = signupView.getIDTextFieldText()
    if hasOnlyAlphabetAndNumber(text: text) {
    } else {
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
        let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9]$", options: .caseInsensitive)
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
    if text.count <= 5 || hasOnlyAlphabetAndNumber(text: text) {
      signupView.setIDLimitExplanationLabel(textColor: .orange)
    } else {
      signupView.setIDLimitExplanationLabel(textColor: .green)
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
