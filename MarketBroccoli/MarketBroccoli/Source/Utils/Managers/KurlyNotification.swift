//
//  AlarmManager.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import SnapKit

class KurlyNotification {
  static let shared = KurlyNotification()
  private let warningView = UILabel().then {
    $0.backgroundColor = .systemPink
    $0.textColor = .white
    $0.layer.cornerRadius = 5
    $0.layer.masksToBounds = true
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 20, weight: .bold)
  }
  
  private var activityIndicatorView = UIActivityIndicatorView()
  private init() { }
  
  func notification(text: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    guard let window = appDelegate.window else { return }
    
    warningView.text = text
    window.addSubview(warningView)
    
    warningView.snp.makeConstraints {
      $0.bottom.equalTo(window.snp.top)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.88)
      $0.height.equalTo(54)
    }
    activityIndicatorView.isHidden = false
    activityIndicatorView.startAnimating()
    
    UIView.animate(withDuration: 0.4) {
      self.warningView.transform = .init(translationX: 0, y: 100)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
      UIView.animateKeyframes(withDuration: 0.4, delay: 0, animations: {
        self.warningView.transform = .identity
      }, completion: { _ in
        self.warningView.removeFromSuperview()
      })
    }
  }
}
