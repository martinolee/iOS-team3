//
//  UserInfoTableViewCell.swift
//  LibrariesPractice
//
//  Created by Soohan Lee on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit
import Then

final class UserInfoTableViewCell: UITableViewCell {
  // MARK: - Properties
  
  private let userProfileImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.layer.borderWidth = 1.0
    $0.layer.borderColor = UIColor.gray.cgColor
    $0.layer.cornerRadius = 6.0
    $0.layer.masksToBounds = true
  }
  
  private let userNameLabel = UILabel().then {
    $0.textAlignment = .left
    $0.numberOfLines = 1
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 18, weight: .medium)
    $0.text = "Steve Jobs님"
    $0.backgroundColor = .purple
  }
  
  private let extraInfoLabel = UILabel().then {
    $0.textAlignment = .left
    $0.numberOfLines = 1
    $0.textColor = .label
    $0.font = .systemFont(ofSize: 16, weight: .light)
    $0.text = "5% 적립 + 최초 1회 무료배송"
    $0.backgroundColor = .brown
  }
  
  private let leftButton = UIButton(type: .system).then {
    $0.setTitle("Left Button", for: .normal)
    $0.layer.cornerRadius = $0.bounds.height / 2
    $0.layer.masksToBounds = true
    $0.backgroundColor = .gray
    $0.titleLabel?.textColor = .black
  }
  
  private let rightButton = UIButton(type: .system).then {
    $0.setTitle("Right Button", for: .normal)
    $0.layer.cornerRadius = $0.bounds.height / 2
    $0.layer.masksToBounds = true
    $0.backgroundColor = .gray
    $0.titleLabel?.textColor = .black
  }
  
  // MARK: - Initialization
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addAllView()
    setupUserProfileImageViewAutoLayout()
    setupUserNameLabelAutoLayout()
    setupExtraInfoLabelAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuration
  
  // MARK: - Setup UI
  
  private func addAllView() {
    contentView.addSubview(userProfileImageView)
    contentView.addSubview(userNameLabel)
    contentView.addSubview(extraInfoLabel)
    contentView.addSubview(leftButton)
    contentView.addSubview(rightButton)
  }
  
  private func setupUserProfileImageViewAutoLayout() {
    userProfileImageView.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).inset(10)
      make.leading.equalTo(contentView.snp.leading).inset(10)
      make.bottom.equalTo(contentView.snp.bottom).inset(10)
      make.size.equalTo(50)
    }
  }
  
  private func setupUserNameLabelAutoLayout() {
    userNameLabel.snp.makeConstraints { make in
      make.top.equalTo(userProfileImageView.snp.top)
      make.leading.equalTo(userProfileImageView.snp.trailing)
      make.trailing.equalTo(contentView.snp.trailing)
      make.bottom.equalTo(contentView.snp.centerY)
    }
  }
  
  private func setupExtraInfoLabelAutoLayout() {
    extraInfoLabel.snp.makeConstraints { make in
      make.top.equalTo(userProfileImageView.snp.centerY)
      make.leading.equalTo(userNameLabel.snp.leading)
      make.trailing.equalTo(userNameLabel.snp.trailing)
      make.bottom.equalTo(userProfileImageView.snp.bottom)
    }
  }
  
  private func setupLeftButtonAutoLayout() {
    leftButton.snp.makeConstraints { make in
      make.top.equalTo(userProfileImageView.snp.bottom)
    }
  }
  
  private func setupRightButtonAutoLayout() {
    
  }
}
