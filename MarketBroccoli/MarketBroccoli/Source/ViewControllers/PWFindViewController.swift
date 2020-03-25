//
//  PWFindViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PWFindViewController: UIViewController {
  private var nameTextField = UITextField().then {
    $0.placeholder = "이름을 입력해주세요."
    $0.textFieldStyle()
  }
  private var idTextField = UITextField().then {
    $0.placeholder = "아이디를 입력해주세요."
    $0.textFieldStyle()
  }
  private var emailTextField = UITextField().then {
    $0.placeholder = "가입한 이메일을 입력해주세요."
    $0.textFieldStyle()
  }
  private var submitButton = UIButton().then {
    $0.setTitle("확인", for: .normal)
    $0.roundPurpleBtnStyle()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setUI()
    setLayout()
  }
  private func setNavigation() {
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationItem.title = "비밀번호 찾기"
  }
  private func setUI() {
    view.backgroundColor = .white
    emailTextField.keyboardType = .emailAddress
    [nameTextField, idTextField, emailTextField, submitButton].forEach {
      view.addSubview($0) }
  }
  private func setLayout() {
    let guide = view.safeAreaLayoutGuide
    let margin: CGFloat = 32
    let height: CGFloat = 14
    let btnTopMargin: CGFloat = 12
    nameTextField.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(guide.snp.height).dividedBy(height)
      make.top.equalTo(guide.snp.top).offset(margin)
      make.left.equalTo(guide.snp.left).offset(margin)
      make.right.equalTo(guide.snp.right).offset(-margin)
    }
    idTextField.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(guide.snp.height).dividedBy(height)
      make.top.equalTo(nameTextField.snp.bottom).offset(btnTopMargin)
      make.left.equalTo(guide.snp.left).offset(margin)
      make.right.equalTo(guide.snp.right).offset(-margin)
    }
    emailTextField.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(guide.snp.height).dividedBy(height)
      make.top.equalTo(idTextField.snp.bottom).offset(btnTopMargin)
      make.left.equalTo(guide.snp.left).offset(margin)
      make.right.equalTo(guide.snp.right).offset(-margin)
    }
    submitButton.snp.makeConstraints { (make) -> Void in
      make.height.equalTo(guide.snp.height).dividedBy(height)
      make.top.equalTo(emailTextField.snp.bottom).offset(margin)
      make.left.equalTo(guide.snp.left).offset(margin)
      make.right.equalTo(guide.snp.right).offset(-margin)
    }
  }
  
  @objc private func didTapSubmitButton() {
  }
}
