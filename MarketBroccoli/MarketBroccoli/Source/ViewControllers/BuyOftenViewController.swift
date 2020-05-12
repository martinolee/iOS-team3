//
//  BuyOftenViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class BuyOftenViewController: UIViewController {
  // MARK: - Properties
  private let stateLabel = UILabel().then {
    $0.text = "아직 구매한 상품이 없습니다."
    $0.textColor = .lightGray
    $0.font = UIFont.systemFont(ofSize: 18)
  }
  
  private lazy var bestButton = UIButton().then {
    $0.setTitle("베스트 상품 보러가기", for: .normal)
    $0.circleLineBtnStyle()
  }
   // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupNavigtion()
    setupLayout()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    bestButton.makeCircleButton()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.setupBroccoliNavigationBar(title: "카테고리")
    self.addNavigationBarCartButton()
  }
  // MARK: - Setup Attribute
  
  private func setupUI() {
    view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
    [stateLabel, bestButton] .forEach {
      view.addSubview($0)
    }
  }
  
  private func setupNavigtion() {
    self.setupSubNavigationBar(title: "자주 사는 상품")
    self.addSubNavigationBarCartButton()
  }
  
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    stateLabel.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(guide.snp.centerX)
      make.centerY.equalTo(guide.snp.centerY).offset(-160)
    }
    bestButton.snp.makeConstraints { (make) -> Void in
      make.centerX.equalTo(guide.snp.centerX)
      make.top.equalTo(stateLabel.snp.bottom).offset(24)
      make.width.equalTo(guide.snp.width).multipliedBy(0.46)
      make.height.equalTo(guide.snp.height).multipliedBy(0.06)
    }
  }
}
