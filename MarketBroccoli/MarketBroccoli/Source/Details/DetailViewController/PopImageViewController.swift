//
//  PopImageViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/09.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class PopImageViewController: UIViewController {
  private let customNaviView = UIView().then {
    $0.backgroundColor = .black
    $0.alpha = 0.5
  }
  
  private lazy var closeBtn = UIButton().then {
    $0.setImage(UIImage(systemName: "xmark"), for: .normal)
    $0.addTarget(self, action: #selector(closeBtnTouched(_:)), for: .touchUpInside)
    $0.tintColor = .white
  }
  
  private lazy var scrollView = UIScrollView().then {
    $0.delegate = self
    $0.bounces = false
    $0.minimumZoomScale = 1.0
    $0.maximumZoomScale = 2.0
    $0.alwaysBounceVertical = false
    $0.alwaysBounceHorizontal = false
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
  }
  private let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
  }
  
  var popupImage: UIImage? {
    willSet {
      imageView.image = newValue
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  var ratio: CGFloat?
  var isVertical: Bool = true
}

extension PopImageViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
}

// MARK: - ACTIONS
extension PopImageViewController {
  @objc private func closeBtnTouched(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  func configure(image: UIImage) {
    popupImage = image
    ratio = image.size.width / image.size.height
    
    let deviceSize = UIScreen.main.bounds
    let deviceRatio = deviceSize.width / deviceSize.height
    let imageRatio = image.size.width / image.size.height
    isVertical = deviceRatio > imageRatio
  }
}

// MARK: - UI
extension PopImageViewController {
  private func setupUI() {
    self.view.addSubviews([scrollView, customNaviView])
    customNaviView.addSubviews([closeBtn])
    scrollView.addSubviews([imageView])
    
    closeBtn.snp.makeConstraints {
      $0.leading.bottom.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 0))
    }
    
    customNaviView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(80)
      $0.width.equalTo(self.view.frame.width)
    }
    
    scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    imageView.snp.makeConstraints {
      $0.width.equalTo(imageView.snp.height).multipliedBy(ratio ?? 0)
      if isVertical {
        $0.height.equalTo(UIScreen.main.bounds.height)
//        $0.top.bottom.equalToSuperview()
//        $0.leading.trailing.equalToSuperview()
      } else {
        $0.width.equalTo(UIScreen.main.bounds.width)
      }
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
//      $0.width.equalToSuperview().multipliedBy(0.8)
//      $0.center.equalToSuperview()
    }
  }
}
