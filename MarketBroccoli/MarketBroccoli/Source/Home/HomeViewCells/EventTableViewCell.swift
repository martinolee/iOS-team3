//
//  EventTableViewCell.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Kingfisher

class EventTableViewCell: UITableViewCell {
  private let eventImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    $0.clipsToBounds = true
  }
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension EventTableViewCell {
  func configure(imageUrl: String) {
    guard let url = URL(string: imageUrl) else { return }
    ImageDownloader.default.downloadImage(with: url) { res in
      switch res {
      case .success(let image):
        let resizedImage = image.image.resized(to: CGSize(width: UIScreen.main.bounds.width, height: 200))
        self.eventImageView.image = resizedImage
      case .failure(let error):
        print(error)
      }
    }
  }
}

// MARK: - UI
extension EventTableViewCell {
  private func setupUI() {
    self.contentView.addSubviews([eventImageView])
    
    eventImageView.snp.makeConstraints {
      $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0))
      $0.height.equalTo(200)
    }
  }
}
