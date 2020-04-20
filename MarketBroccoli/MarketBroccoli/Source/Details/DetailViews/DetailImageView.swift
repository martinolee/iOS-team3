//
//  DetailImageView.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailImageView: UIScrollView {
  private lazy var detailImageView = UIImageView().then {
    let imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTouched(_:)))
    $0.image = UIImage(named: "harman-kardon")
    $0.contentMode = .scaleAspectFill
    $0.isUserInteractionEnabled = true
    $0.addGestureRecognizer(imageTap)
  }
  
  private var isVertical: Bool = true
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - ACTIONS
extension DetailImageView {
  @objc private func imageTouched(_ sender: UITapGestureRecognizer) {
    ObserverManager.shared.post(
      observerName: .imageTouched,
      object: nil,
      userInfo: ["image": UIImage(named: "harman-kardon")!]
    )
  }
}

// MARK: - UI
extension DetailImageView {
  private func setupUI() {
    self.addSubviews([detailImageView])
    detailImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalToSuperview()
      if !isVertical {
        $0.center.equalToSuperview()
      }
    }
  }
}
