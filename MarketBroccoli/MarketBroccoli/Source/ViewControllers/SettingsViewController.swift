//
//  SettingsViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  private let settingOpt = [
    ["Login"],
    ["비회원 주문 조회"],
    ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개"],
    ["알림설정"]
  ]
  
  private let myCurlyTableView = UITableView().then {
    $0.sectionFooterHeight = 10
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
}

// MARK: - UI
extension SettingsViewController {
  private func setupAttr() {
    myCurlyTableView.dataSource = self
    myCurlyTableView.delegate = self
    myCurlyTableView.register(cell: LogOutTableViewCell.self)
    myCurlyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Detail")
    self.myCurlyTableView.backgroundColor = .lightGray
    self.title = "마이컬리"
  }
  
  private func setupUI() {
    view.addSubviews([myCurlyTableView])
    myCurlyTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    setupAttr()
  }
    
  @objc func didTapSingUpInButton() {
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.navigationBar.tintColor = .black
        self.present(loginVC, animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    settingOpt.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    settingOpt[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeue(LogOutTableViewCell.self)
      cell.delegate = self
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath) 
      cell.textLabel?.text = settingOpt[indexPath.section][indexPath.row]
      return cell
    }
  }
}

extension SettingsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.rowHeight))
    footerView.backgroundColor = .lightGray
    
    return footerView
  }
}

extension SettingsViewController: LogOutTableViewCellDelegate {
  func signInBonusButtonTouched(_ button: UIButton) {
    print("가입 혜택 버튼 클릭됨")
  }
  
  func logInButtonDidTouched(_ button: UIButton) {
    let nextVC = UINavigationController(rootViewController: LoginViewController())
    nextVC.modalPresentationStyle = .fullScreen
    self.present(nextVC, animated: true)
  }
}
