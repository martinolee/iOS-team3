//
//  LogOutViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {
  private let settingOpt = [["Login"], ["비회원 주문 조회"], ["배송 안내", "공지사항", "자주하는 질문", "고객센터", "이용안내", "컬리소개"], ["알림설정"]]
  private let myCurlyTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.myCurlyTableView.backgroundColor = .lightGray
    setupUI()
  }
  private func setupUI() {
    [myCurlyTableView].forEach {
      view.addSubview($0)
    }
    self.title = "마이컬리"
    myCurlyTableView.dataSource = self
    myCurlyTableView.delegate = self
    myCurlyTableView.sectionFooterHeight = 10
    myCurlyTableView.rowHeight = UITableView.automaticDimension
    
    myCurlyTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: LogOutTableViewCell.identifier)
    myCurlyTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Detail")
 
    constraints()
  }
  
  private func constraints() {
    myCurlyTableView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
extension LogOutViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    settingOpt.count
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    settingOpt[section].count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      guard let cell0 = tableView.dequeueReusableCell(
        withIdentifier: LogOutTableViewCell.identifier,
        for: indexPath) as? LogOutTableViewCell else { fatalError() }
      return cell0
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "Detail", for: indexPath) 
      cell.textLabel?.text = settingOpt[indexPath.section][indexPath.row]
      
      return cell
    }
  }
}

extension LogOutViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: tableView.rowHeight))
    footerView.backgroundColor = .lightGray
    
    return footerView
  }
}
