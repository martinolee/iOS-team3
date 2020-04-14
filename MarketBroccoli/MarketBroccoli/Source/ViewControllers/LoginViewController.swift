//
//  LoginViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  private var idTextField = UITextField().then {
    $0.placeholder = "아이디를 입력해주세요"
    $0.textFieldStyle()
  }
  private var pwTextField = UITextField().then {
    $0.placeholder = "비밀번호를 입력해주세요"
    $0.isSecureTextEntry = true
    $0.textFieldStyle()
  }
  private var logInButton = UIButton().then {
    $0.setTitle("로그인", for: .normal)
    $0.roundPurpleBtnStyle()
    $0.addTarget(self, action: #selector(logInButtonTouched), for: .touchUpInside)
  }
  private var idFindButton = UIButton().then {
    $0.setTitle("아이디 찾기 |", for: .normal)
    $0.setTitleColor(.darkGray, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
  }
  private var pwFindButton = UIButton().then {
    $0.setTitle("비밀번호 찾기", for: .normal)
    $0.setTitleColor(.darkGray, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
  }
  private var signUpButton = UIButton().then {
    $0.setTitle("회원가입", for: .normal)
    $0.roundLineBtnStyle()
  }
  
  private enum UI {
    static let margin: CGFloat = 32
    static let height: CGFloat = 14
    static let btnBetweenMargin: CGFloat = 40
    static let btnTopMargin: CGFloat = 12
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
  }
}

// MARK: - UI
extension LoginViewController {
  private func setupNavigation() {
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationItem.title = "로그인"
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage.init(systemName: "xmark"),
      style: .done,
      target: self,
      action: #selector(didTapCancelButton)
    )
    self.navigationItem.leftBarButtonItem?.tintColor = .black
  }
  
  private func setupAttr() {
    view.backgroundColor = .white
    signUpButton.addTarget(self, action: #selector(didTapsignUpButton(_:)), for: .touchUpInside)
    idFindButton.addTarget(self, action: #selector(didtapFindButton(_:)), for: .touchUpInside)
    pwFindButton.addTarget(self, action: #selector(didtapFindButton(_:)), for: .touchUpInside)
  }
  
  private func setupUI() {
    view.addSubviews([idTextField, pwTextField, logInButton, idFindButton, pwFindButton, signUpButton])
    let guide = view.safeAreaLayoutGuide
    
    idTextField.snp.makeConstraints {
      $0.top.equalTo(guide.snp.top).offset(UI.margin)
      $0.leading.equalTo(guide.snp.leading).offset(UI.margin)
      $0.trailing.equalTo(guide.snp.trailing).offset(-UI.margin)
      $0.height.equalTo(guide.snp.height).dividedBy(UI.height)
    }
    pwTextField.snp.makeConstraints {
      $0.top.equalTo(idTextField.snp.bottom).offset(UI.btnTopMargin)
      $0.leading.equalTo(guide.snp.leading).offset(UI.margin)
      $0.trailing.equalTo(guide.snp.trailing).offset(-UI.margin)
      $0.height.equalTo(guide.snp.height).dividedBy(UI.height)
    }
    logInButton.snp.makeConstraints {
      $0.top.equalTo(pwTextField.snp.bottom).offset(24)
      $0.leading.equalTo(guide.snp.leading).offset(UI.margin)
      $0.trailing.equalTo(guide.snp.trailing).offset(-UI.margin)
      $0.height.equalTo(guide.snp.height).dividedBy(UI.height)
    }
    idFindButton.snp.makeConstraints {
      $0.top.equalTo(logInButton.snp.bottom).offset(UI.btnTopMargin)
      $0.centerX.equalTo(guide.snp.centerX).offset(-UI.btnBetweenMargin)
    }
    pwFindButton.snp.makeConstraints {
      $0.top.equalTo(logInButton.snp.bottom).offset(UI.btnTopMargin)
      $0.leading.equalTo(idFindButton.snp.trailing).offset(4)
    }
    signUpButton.snp.makeConstraints {
      $0.top.equalTo(idFindButton.snp.bottom).offset(UI.btnBetweenMargin)
      $0.leading.equalTo(guide.snp.leading).offset(UI.margin)
      $0.trailing.equalTo(guide.snp.trailing).offset(-UI.margin)
      $0.height.equalTo(guide.snp.height).dividedBy(UI.height)
    }
    setupAttr()
  }
}

// MARK: - ACTIONS
extension LoginViewController {
  @objc private func didTapCancelButton() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc private func didtapFindButton(_ sender: UIButton) {
    let idFindVC = IDFindViewController()
    let pwFindVC = PWFindViewController()
    switch sender {
    case idFindButton:
      self.navigationController?.pushViewController(idFindVC, animated: true)
    default:
      self.navigationController?.pushViewController(pwFindVC, animated: true)
    }
  }
  
  @objc private func didTapsignUpButton(_ sender: UIButton) {
    let nextVC = SignUpViewController()
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
  @objc private func logInButtonTouched() {
  }
}
