//
//  CategoryViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
  var tableView = UITableView(frame: .zero, style: .grouped)
  let oftenProduct = ["자주 사는 상품"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigation()
    setupUI()
    setupLayout()
  }
  private func setupNavigation() {
    self.navigationItem.title = "카테고리"
  }
  
  private func setupUI() {
    view.backgroundColor = .white
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableHeaderView =
      UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height) * 0.02))
    tableView.tableFooterView =
      UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (view.frame.height) * 0.02))
//    tableView.separatorStyle = .none // 테이블 뷰 라인 없애기
    tableView.register(cell: CategoryTableViewCell.self)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "often")
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "temp")
    [tableView].forEach {
      view.addSubview($0)
    }
  }
  
  private func setupLayout() {
    let guide = view.safeAreaLayoutGuide
    tableView.snp.makeConstraints { (make) -> Void in
      make.edges.equalTo(guide)
    }
  }
}

// MARK: - TableViewDataSource
extension CategoryViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
//    3
    return categoryData.count + 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "often", for: indexPath)
      cell.textLabel?.text = oftenProduct[indexPath.section]
      cell.textLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
      let image = UIImageView(image: UIImage(systemName: "chevron.right"))
      cell.accessoryView = image
      cell.accessoryView?.tintColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
      return cell
    case 16:
      let cell = tableView.dequeueReusableCell(withIdentifier: "temp", for: indexPath)
      cell.textLabel?.text = "컬리의 추천"
      return cell
    default:
      let cell = tableView.dequeue(CategoryTableViewCell.self)
            let data = categoryData[indexPath.section - 1]
            cell.titleName(name: data.title)
            cell.subCategory(data: data)
            cell.separatorInset = .zero
            return cell
    }
  }
}

// MARK: - TableViewDelegate
extension CategoryViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0, 16:
      print(indexPath.section)
    default:
      categoryData[indexPath.section - 1].select.toggle()
      tableView.reloadData()
      print(categoryData[indexPath.section - 1].select)
      print(indexPath.section)
    }
  }
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       return UIView()
   }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return " "
  }
  
  func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    return "footer"
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    switch section {
    case 16:
      return 20
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    switch section {
    case 0:
      return 20
    default:
      return 0
    }
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     if indexPath.section == 0 {
       return 60
     } else {
       return UITableView.automaticDimension
     }
   }
}
