//
//  PWFindViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PWFindViewController: UIViewController {
  private let PWFView = PWFindView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
  }
  
  func setupUI() {
    view.addSubview(PWFView)
    let guide = view.safeAreaLayoutGuide
    PWFView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setupNavigation() {
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationItem.title = "비밀번호 찾기"
  }
}
