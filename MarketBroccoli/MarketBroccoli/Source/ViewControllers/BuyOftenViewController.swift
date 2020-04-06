//
//  BuyOftenViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

// MARK: - Properties

private let stateLabel = UILabel().then {
  $0.text = "아직 구매한 상품이 없습니다."
  $0.textColor = .lightGray
  $0.font = UIFont.systemFont(ofSize: 16)
}
class BuyOftenViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupNavigtion()
    setupLayout()
  }
  // MARK: - Life Cycle
  
  override func viewWillDisappear(_ animated: Bool) {
    self.addNavigationBarCartButton()
    self.setupBroccoliNavigationBar(title: "카테고리")
  }
  // MARK: - Setup Attribute
  
  private func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    [stateLabel].forEach {
      view.addSubview($0)
    }
  }
  private func setupNavigtion() {
    self.setupSubNavigationBar(title: "자주 사는 상품")
  }
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    stateLabel.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(guide.snp.centerX)
      make.centerY.equalTo(guide.snp.centerY).offset(-160)
    }
  }
}
