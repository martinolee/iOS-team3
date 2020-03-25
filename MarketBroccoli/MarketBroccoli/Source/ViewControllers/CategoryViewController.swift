//
//  CategoryViewController.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

struct TempCategory {
  var select: Bool
  let title: String
  let imagePurple: String
  let imageBlack: String
  let row: [String]
}

let item1: [TempCategory] = [TempCategory(select: false, title: "채소", imagePurple: "채소_보라", imageBlack: "채소_검정", row: ["전체보기", "기본채소", "쌈·샐러드·간편채소"])]
//let items2: [TempCategory] = [
//    TempCategory(select: false, title: "채소", row: ["전체보기", "기본채소", "쌈"]),
//    TempCategory(select: false, title: "과일·견과·쌀", row: ["국산과일", "수입과일"])
//]

class CategoryViewController: UIViewController {
    
    var tableView = UITableView()
    let oftenProduct = ["자주 사는 상품"]
    let items = ["채소", "과일·견과·쌀", "수산·해산·건어물", "정육·계란", "국·반찬·메인요리", "샐러드·간편식", "면·양념·오일", "음료·우유·떡·간식", "베이컨·치즈·델리", "건강식품", "생활용품", "주방용품", "가전제품", "베이비·키즈", "반려동물"]
    
    let itemImage = ["icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce" ,"icon_sauce"]
    
    let temp = ["컬리의 추천"]
    
    override func viewDidLoad() {
      super.viewDidLoad()
      setNavigation()
      setUI()
      setLayout()
      
    }
    private func setNavigation() {
      self.navigationItem.title = "카테고리"
    }
    
    private func setUI() {
      view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CategoryDisableTableViewCell.self, forCellReuseIdentifier: CategoryDisableTableViewCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "often")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "temp")
        [tableView].forEach {
        view.addSubview($0)
        }
    }
    
    private func setLayout() {
      let guide = view.safeAreaLayoutGuide
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(guide)
        }
    }
}

// MARK: - TableViewDataSource
extension CategoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
      3
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//      return 30
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return items.count
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "often", for: indexPath)
            cell.textLabel?.text = oftenProduct[indexPath.row]
            cell.textLabel?.textColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
            
            let image = UIImageView(image: UIImage(systemName: "chevron.right"))
            cell.accessoryView = image
            cell.accessoryView?.tintColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDisableTableViewCell.identifier, for: indexPath) as? CategoryDisableTableViewCell else { return UITableViewCell() }
            cell.titleName(name: items[indexPath.row])
            return cell
           
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "temp", for: indexPath)
            cell.textLabel?.text = temp[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "often", for: indexPath)
            cell.textLabel?.text = items[indexPath.row]
            return cell
        }
    }
}

// MARK: - TableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
