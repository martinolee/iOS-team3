//
//  LogOutViewController.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class LogOutViewController: UIViewController {

      private let myCurlyTableView = UITableView()
      
      override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
      }
      private func setupUI() {
        [myCurlyTableView].forEach {
          view.addSubview($0)
        }
        self.title = "마이컬리"
        
    //    self.navigationItem.leftBarButtonItem = self.lef
      
        
        myCurlyTableView.dataSource = self
        myCurlyTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: LogOutTableViewCell.identifier)
        constraints()
      }
      
      private func constraints() {
      
        let guide = view.safeAreaLayoutGuide
        
        myCurlyTableView.snp.makeConstraints {
          $0.top.equalTo(guide.snp.top)
          $0.leading.equalTo(guide.snp.leading)
          $0.trailing.equalTo(guide.snp.trailing)
          $0.height.equalTo(guide.snp.height).multipliedBy(0.35)
        }
      }
    }
    extension LogOutViewController: UITableViewDataSource {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LogOutTableViewCell.identifier, for: indexPath) as! LogOutTableViewCell
        return cell
      }
      
      
}
