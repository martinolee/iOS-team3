//
//  ProductCollectionHeader.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/04/06.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol ProductCollectionHeaderDelegate: class {
}

class ProductCollectionHeader: UICollectionReusableView {
  // MARK: - Properties
  
  weak var delegate: ProductCollectionHeaderDelegate?
  
  private var isInitialized = false
  
  private var isSelectingDeliveryAreaViewOpen: Bool {
    get { selectingDeliveryAreaView.isHidden }
    
    set { selectingDeliveryAreaView.isHidden = newValue }
  }
  
  private var isSelectingOrderTypeViewOpen: Bool {
    get { selectingOrderTypeView.isHidden }
    
    set { selectingOrderTypeView.isHidden = newValue }
  }
  
  private lazy var selectingDeliveryAreaButton = UIButton(type: .system).then {
    $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    $0.setPreferredSymbolConfiguration(.init(pointSize: 14), forImageIn: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.tintColor = .black
    $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    
    $0.addTarget(self, action: #selector(selectingDeliveryAreaButtonTouched(_:)), for: .touchUpInside)
  }
  
  private lazy var selectingOrderTypeButton = UIButton(type: .system).then {
    $0.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    $0.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
    
    $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    $0.setPreferredSymbolConfiguration(.init(pointSize: 14), forImageIn: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.tintColor = .black
    $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
    
    $0.addTarget(self, action: #selector(selectingOrderTypeButtonTouched(_:)), for: .touchUpInside)
  }
  
  private let selectingDeliveryAreaView = UIStackView().then {
    $0.axis = .vertical
    $0.isHidden = true
  }
  
  private let selectingOrderTypeView = UIStackView().then {
    $0.axis = .vertical
    $0.isHidden = true
  }
  
  // MARK: - Life Cycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addAllView()
    setupAutoLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Setup UI
  
  private func setupAttribute() {
    self.clipsToBounds = false
  }
  
  private func addAllView() {
    self.addSubviews([
      selectingDeliveryAreaButton,
      selectingOrderTypeButton,
      selectingDeliveryAreaView,
      selectingOrderTypeView
    ])
  }
  
  private func setupAutoLayout() {
    selectingDeliveryAreaButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(8)
      $0.leading.equalToSuperview().inset(22)
    }
    
    selectingOrderTypeButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(8)
      $0.trailing.equalToSuperview().inset(22)
    }
    
    selectingDeliveryAreaView.snp.makeConstraints {
      $0.top.equalTo(selectingDeliveryAreaButton.snp.bottom).offset(16)
      $0.leading.equalTo(selectingDeliveryAreaButton)
    }
    
    selectingOrderTypeView.snp.makeConstraints {
      $0.top.equalTo(selectingOrderTypeButton.snp.bottom).offset(16)
      $0.trailing.equalTo(selectingOrderTypeButton)
    }
  }
}

extension ProductCollectionHeader {
  @objc
  private func selectingDeliveryAreaButtonTouched(_ button: UIButton) {
    isSelectingDeliveryAreaViewOpen.toggle()
    
    selectingDeliveryAreaView.isHidden.toggle()
    
    let image: UIImage?
    isSelectingDeliveryAreaViewOpen ?
      (image = UIImage(systemName: "chevron.up")) :
      (image = UIImage(systemName: "chevron.down"))
    
    selectingDeliveryAreaButton.setImage(image, for: .normal)
  }
  
  @objc
  private func selectingOrderTypeButtonTouched(_ button: UIButton) {
    isSelectingOrderTypeViewOpen.toggle()
    
    selectingOrderTypeView.isHidden.toggle()
    
    let image: UIImage?
    isSelectingDeliveryAreaViewOpen ?
      (image = UIImage(systemName: "chevron.up")) :
      (image = UIImage(systemName: "chevron.down"))
    
    selectingDeliveryAreaButton.setImage(image, for: .normal)
  }
}

extension ProductCollectionHeader {
  func configure(hideOrderTypeButton hide: Bool, deliveryAreas: [String], orderTypes: [String]) {
    if !isInitialized {
      selectingOrderTypeButton.isHidden = hide
      
      if let deliveryAreaButtonTitle = deliveryAreas.first {
        selectingDeliveryAreaButton.setTitle(deliveryAreaButtonTitle, for: .normal)
      }
      
      if let orderTypeButtonTitle = orderTypes.first {
        selectingOrderTypeButton.setTitle(orderTypeButtonTitle, for: .normal)
      }
      
      let backgroundView = UIView().then { $0.backgroundColor = .white }
      
      deliveryAreas.forEach { deliveryArea in
        let button = UIButton(type: .system).then {
          $0.setTitle(deliveryArea, for: .normal)
          $0.setTitleColor(.black, for: .normal)
        }
        selectingDeliveryAreaView.addArrangedSubview(button)
      }
      selectingDeliveryAreaView.insertSubview(backgroundView, at: 0)
      
      orderTypes.forEach { orderType in
        let button = UIButton(type: .system).then {
          $0.contentHorizontalAlignment = .right
          $0.setTitle(orderType, for: .normal)
          $0.setTitleColor(.black, for: .normal)
        }
        selectingOrderTypeView.addArrangedSubview(button)
      }
      selectingOrderTypeView.insertSubview(backgroundView, at: 0)
      
      isInitialized = true
    }
  }
}

extension ProductCollectionHeader {
  private func toggle() {
  }
}
