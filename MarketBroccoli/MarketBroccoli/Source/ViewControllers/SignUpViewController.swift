//
//  SignUpViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
  private let signupView = SignupView()

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

