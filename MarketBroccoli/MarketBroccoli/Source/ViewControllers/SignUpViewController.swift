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
  var count = 0
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

extension SignUpViewController: SignupViewDelegate {
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
    return updatedText.count <= 12
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
    return updatedText.count <= 4
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
