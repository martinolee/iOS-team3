//
//  CategoryTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {
  static let identifier = "categoryCell"
  
  let tableView = UITableView()
  private let iconImage = UIImageView()
  private let title = UILabel()
  private let arrowImage = UIImageView()
  private let subCategoryView = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    setupLayout()
  }
  
  func subCategory(data: CategoryModel) {
    if data.select == false {
      arrowImage.image = UIImage(systemName: "chevron.down")
      iconImageName(name: data.imageBlack)
      title.textColor = .black
    } else {
      arrowImage.image = UIImage(systemName: "chevron.up")
      iconImageName(name: data.imagePurple)
      title.textColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
    }

    switch data.select {
    case true:
      subCategoryView.isHidden = false
    case false:
      subCategoryView.isHidden = true
    }
  }
  
  private func setupUI() {
    iconImage.image = UIImage(named: "icon_sauce")
    iconImage.contentMode = .scaleAspectFit
    arrowImage.image = UIImage(systemName: "chevron.down")
    arrowImage.contentMode = .scaleAspectFit
    arrowImage.tintColor = .darkGray
    subCategoryView.backgroundColor = .systemTeal
    
//    tableView.separatorStyle = .none
//    tableView.backgroundColor = .systemGray
//    tableView.dataSource = self
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test")
    
    [iconImage, title, arrowImage, subCategoryView, tableView].forEach {
      contentView.addSubview($0)
    }
  }
  
  private func setupLayout() {
    iconImage.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(contentView.snp.centerY)
      make.leading.equalTo(contentView.snp.leading).offset(10)
      make.width.height.equalTo(40)
    }
    title.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(contentView.snp.top).offset(20)
      make.leading.equalTo(iconImage.snp.trailing).offset(8)
      make.bottom.equalToSuperview().offset(-20)
    }
    arrowImage.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(contentView.snp.centerY)
      make.trailing.equalTo(contentView.snp.trailing).offset(-20)
      make.width.height.equalTo(20)
    }
//    subCategoryView.snp.makeConstraints { (make) -> Void in
//      make.top.equalTo(iconImage.snp.bottom).offset(10)
//      make.leading.equalTo(contentView.snp.leading)
//      make.trailing.equalTo(contentView.snp.trailing)
//      make.height.equalTo(contentView.snp.height).multipliedBy(2)
//    }

  }
  
  func titleName(name: String) {
    title.text = name
  }
  
  func iconImageName(name: String) {
    iconImage.image = UIImage(named: name)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension CategoryTableViewCell: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return categoryData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
    cell.textLabel?.text = categoryData[indexPath.row].title
    cell.textLabel?.textColor = .systemPink
    return cell
  }
}
