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
    $0.textFieldStyle()
  }
  private var logInbtn = UIButton().then {
    $0.setTitle("로그인", for: .normal)
    $0.roundPurpleBtnStyle()
  }
  private var idFindBtn = UIButton().then {
    $0.setTitle("아이디 찾기 |", for: .normal)
    $0.setTitleColor(.darkGray, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
  }
  private var pwFindBtn = UIButton().then {
    $0.setTitle("비밀번호 찾기", for: .normal)
    $0.setTitleColor(.darkGray, for: .normal)
    $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
  }
  private var signUpBtn = UIButton().then {
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
    signUpBtn.addTarget(self, action: #selector(didTapsignUpButton(_:)), for: .touchUpInside)
  }
  
  private func setupUI() {
    view.addSubviews([idTextField, pwTextField, logInbtn, idFindBtn, pwFindBtn, signUpBtn])
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
    logInbtn.snp.makeConstraints {
      $0.top.equalTo(pwTextField.snp.bottom).offset(24)
      $0.leading.equalTo(guide.snp.leading).offset(UI.margin)
      $0.trailing.equalTo(guide.snp.trailing).offset(-UI.margin)
      $0.height.equalTo(guide.snp.height).dividedBy(UI.height)
    }
    idFindBtn.snp.makeConstraints {
      $0.top.equalTo(logInbtn.snp.bottom).offset(UI.btnTopMargin)
      $0.centerX.equalTo(guide.snp.centerX).offset(-UI.btnBetweenMargin)
    }
    
    pwFindBtn.snp.makeConstraints {
      $0.top.equalTo(logInbtn.snp.bottom).offset(UI.btnTopMargin)
      $0.leading.equalTo(idFindBtn.snp.trailing).offset(4)
    }
    signUpBtn.snp.makeConstraints {
      $0.top.equalTo(idFindBtn.snp.bottom).offset(UI.btnBetweenMargin)
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
  
  @objc private func didtapFindButton() {}
  
  @objc private func didTapsignUpButton(_ sender: UIButton) {
    let nextVC = SignUpViewController()
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
}
