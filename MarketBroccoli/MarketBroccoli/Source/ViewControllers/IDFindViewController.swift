//
//  IDFindViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit

class IDFindViewController: UIViewController {
  private let IDFView = IDFindView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setNavigation()
    setupUI()
  }
  
  func setupUI() {
    view.addSubview(IDFView)
    let guide = view.safeAreaLayoutGuide
    
    IDFView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.bottom.equalToSuperview()
    }
  }
  
  private func setNavigation() {
    self.navigationController?.navigationBar.barTintColor = .white
    self.navigationItem.title = "아이디 찾기"
  }
}
