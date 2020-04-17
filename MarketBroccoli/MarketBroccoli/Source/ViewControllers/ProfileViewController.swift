//
//  ProfileViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/14.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  private let settingOptAfterLogin = [
    ["유저 정보"],
    ["적립금", "쿠폰", "친구초대"],
    ["주문 내역", "상품 후기", "상품 문의", "1:1 문의", "대량주문 문의"],
    ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개", "자주하는 질문", "고객센터", "이용안내", "컬리소개", "컬리패스"],
    ["개인정보 수정", "알림설정"],
    ["로그아웃"]
  ]
  
  private let profileTableView = UITableView().then {
    $0.sectionFooterHeight = 10
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      setupUI()
      
      self.addNavigationBarCartButton()
      self.setupBroccoliNavigationBar(title: "마이컬리")
    }
}
// MARK: - UI
extension ProfileViewController {
  private func setupAttr() {
    profileTableView.allowsSelection = false
    profileTableView.dataSource = self
    profileTableView.delegate = self
    profileTableView.register(cell: SettingsTableViewCell.self)
    profileTableView.register(cell: UserInfoTableViewCell.self)
    profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Detail")
    self.profileTableView.backgroundColor = .lightGray
  }
  
  private func setupUI() {
    view.addSubviews([profileTableView])
    profileTableView.snp.makeConstraints {
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

extension ProfileViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
      return settingOptAfterLogin.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return settingOptAfterLogin[section].count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      switch indexPath.section {
      case 0:
        let cell = tableView.dequeue(UserInfoTableViewCell.self)
        cell.configure(name: "스티브잡스")
        return cell
      default:
        let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath)
        cell.textLabel?.text = settingOptAfterLogin[indexPath.section][indexPath.row]
        return cell
      }
  }
}
extension ProfileViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.rowHeight))
    footerView.backgroundColor = .lightGray
    
    return footerView
  }
}
