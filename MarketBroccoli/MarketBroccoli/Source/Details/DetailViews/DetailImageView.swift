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
    $0.contentMode = .scaleAspectFit
    $0.isUserInteractionEnabled = true
    $0.addGestureRecognizer(imageTap)
  }
  open var detailImage: String = "" {
    willSet {
      guard let url = URL(string: newValue) else { return }
      self.detailImageView.setImage(urlString: newValue)
//      self.detailImageView.kf.setImage(
//        with: url,
//        placeholder: UIImage(named: "placeholderImage"),
//        options: []) { [weak self] res in
//          guard let self = self else { return }
//          switch res {
//          case .success(let data):
//            let size = data.image.size
//            let ratio = UIScreen.main.bounds.width / size.width
//            let height = size.height * ratio
//            self.detailImageView.snp.updateConstraints {
//              $0.height.equalTo(height)
//            }
//          case .failure(let error):
//            print(error)
//          }
//      }
    }
  }
  
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
      userInfo: nil
    )
  }
}

// MARK: - UI
extension DetailImageView {
  private func setupUI() {
    self.addSubviews([detailImageView])
    detailImageView.snp.makeConstraints {
      $0.top.bottom.width.equalToSuperview()
      $0.centerY.equalToSuperview()
//      $0.height.equalTo(0)
    }
  }
}
