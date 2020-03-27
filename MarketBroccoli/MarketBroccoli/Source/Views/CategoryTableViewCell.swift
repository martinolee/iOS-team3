//
//  CategoryTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
  static let identifier = "categoryCell"
  
  private let iconImage = UIImageView()
  private let title = UILabel()
  private let arrowImage = UIImageView()
  private let subCategoryView = UIView()
  
  private var bottomConstraint: NSLayoutConstraint?
  
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
    
    var buttons = [UIButton]()
        data.row.forEach {
          let tempButton = UIButton()
          tempButton.setTitle("    \($0)", for: .normal)
          tempButton.setTitleColor(.darkGray, for: .normal)
          tempButton.contentMode = .left
          buttons.append(tempButton)
          subCategoryView.addSubview(tempButton)
        }
        
        buttons.enumerated().forEach { (index, tempButton) in
          tempButton.translatesAutoresizingMaskIntoConstraints = false
          tempButton.leadingAnchor.constraint(equalTo: subCategoryView.leadingAnchor).isActive = true
    //      tempButton.trailingAnchor.constraint(equalTo: rowView.trailingAnchor).isActive = true
          
          switch index {
          case 0, buttons.count - 1:
            tempButton.topAnchor.constraint(equalTo: subCategoryView.topAnchor, constant: 16).isActive = true
            
            tempButton.bottomAnchor.constraint(equalTo: subCategoryView.bottomAnchor, constant: -16).isActive = true
          default:
            tempButton.topAnchor.constraint(equalTo: buttons[index - 1].bottomAnchor, constant: 16).isActive = true
          }
        }
    
    switch data.select {
    case true:
      bottomConstraint?.priority = .defaultLow
      subCategoryView.isHidden = false
    case false:
      bottomConstraint?.priority = .defaultHigh
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
    [iconImage, title, arrowImage, subCategoryView].forEach {
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
      make.centerY.equalTo(contentView.snp.centerY)
      make.leading.equalTo(iconImage.snp.trailing).offset(8)
    }
    arrowImage.snp.makeConstraints { (make) -> Void in
      make.centerY.equalTo(contentView.snp.centerY)
      make.trailing.equalTo(contentView.snp.trailing).offset(-20)
      make.width.height.equalTo(20)
    }
    subCategoryView.snp.makeConstraints { (make) -> Void in
      make.top.equalTo(iconImage.snp.bottom).offset(16)
      make.centerX.equalTo(contentView.snp.centerX)
      make.bottom.equalTo(contentView.snp.bottom).offset(16)
      make.bottom.equalTo(contentView.snp.bottom).priority(250)
    }
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
