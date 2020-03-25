//
//  CategorydisableTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/24.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class CategoryDisableTableViewCell: UITableViewCell {
  
  static let identifier = "disableCell"
  let iconImage = UIImageView()
  private let title = UILabel()
  let arrowImage = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setUI()
    setLayout()
  }
  
  private func setUI() {
    iconImage.image = UIImage(named: "icon_sauce")
    iconImage.contentMode = .scaleAspectFit
    arrowImage.image = UIImage(systemName: "chevron.down")
    arrowImage.contentMode = .scaleAspectFit
    arrowImage.tintColor = .black
    [iconImage, title, arrowImage].forEach {
      contentView.addSubview($0)
    }
  }
  
  private func setLayout() {
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
