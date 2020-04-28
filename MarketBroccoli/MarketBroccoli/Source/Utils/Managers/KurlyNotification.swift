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
  
  private let notifivationView = UILabel().then {
    $0.backgroundColor = .white
    $0.textColor = .kurlyPurple1
    $0.layer.cornerRadius = 5
    $0.layer.masksToBounds = true
    $0.textAlignment = .center
    $0.font = .systemFont(ofSize: 20, weight: .bold)
  }
  
  private let shadowView = UIView().then {
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowOpacity = 0.6
    $0.layer.shadowOffset = .zero
    $0.layer.shadowRadius = 5
    $0.layer.shadowOffset = CGSize(width: 0, height: 4)
    $0.layer.masksToBounds = false
  }
  
  private var activityIndicatorView = UIActivityIndicatorView()
  
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
  
  func notice(text: String) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    guard let window = appDelegate.window else { return }
    
    notifivationView.text = text
    window.addSubview(shadowView)
    shadowView.addSubview(notifivationView)
        
    notifivationView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    shadowView.snp.makeConstraints {
      $0.bottom.equalTo(window.snp.top)
      $0.centerX.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(0.88)
      $0.height.equalTo(54)
    }
    
    activityIndicatorView.isHidden = false
    activityIndicatorView.startAnimating()
    
    UIView.animate(withDuration: 0.25) {
      self.shadowView.transform = .init(translationX: 0, y: 100)
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
      UIView.animateKeyframes(withDuration: 0.4, delay: 0, animations: {
        self.shadowView.transform = .identity
      }, completion: { _ in
        self.notifivationView.removeFromSuperview()
        self.shadowView.removeFromSuperview()
      })
    }
  }
  private init() { }
}
