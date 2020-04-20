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
    $0.alpha = 0.0
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
  private lazy var imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.isUserInteractionEnabled = true
    $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTouched(_:))))
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
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
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    UIView.animate(withDuration: 0.2) {
      self.customNaviView.alpha = 0.5
    }
  }
  
  var imageSize: CGSize = .zero
  var isVertical: Bool = true
}

extension PopImageViewController: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
  let subView = scrollView.subviews[0]
  let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0.0)
  let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0.0)
    subView.center = CGPoint(x: scrollView.contentSize.width * 0.5 + offsetX,
                             y: scrollView.contentSize.height * 0.5 + offsetY)
  }
}

// MARK: - ACTIONS
extension PopImageViewController {
  @objc private func closeBtnTouched(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  @objc private func imageTouched(_ sender: UITapGestureRecognizer) {
    UIView.animate(withDuration: 0.2) {
      self.customNaviView.alpha = self.customNaviView.alpha > 0 ?  0.0 : 0.5
    }
  }
  
  @objc private func imageDissmiss(_ sender: UISwipeGestureRecognizer) {
    if sender.direction == .down {
      print("down")
    }
  }
  
  func configure(image: UIImage) {
    popupImage = image
    imageSize = image.size
    isVertical = imageSize.width < imageSize.height
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
      if isVertical {
        $0.height.equalTo(UIScreen.main.bounds.height)
        $0.center.equalToSuperview()
      } else {
        $0.width.equalTo(UIScreen.main.bounds.width)
      }
      $0.top.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
    }
  }
}
