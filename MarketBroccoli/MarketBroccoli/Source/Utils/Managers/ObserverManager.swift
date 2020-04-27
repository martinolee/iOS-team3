//
//  ObserverManager.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/09.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

class ObserverManager {
  static let shared = ObserverManager()
  private var registerArray: [String] = []
  
  enum NotiNames: String {
    case productTouched = "ProductTouched"
    case showAllBtnTouched = "ShowAllBtnTouched"
    case imageTouched = "ImageTouched"
    case bannerShared = "BannerShared"
    case purchaseBtnTouched = "PurchaseBtnTouched"
    case cartOrAlarmBtnTouched = "CartOrAlarmBtnTouched"
  }
  
  func registerObserver(target: Any, selector: Selector, observerName: NotiNames, object: Any?) {
    if registerArray.contains(observerName.rawValue) {
      print("already registered notification: \(observerName)")
    } else {
      NotificationCenter.default.addObserver(
        target,
        selector: selector,
        name: NSNotification.Name(observerName.rawValue),
        object: object)
      registerArray.append(observerName.rawValue)
      print("add notification success: \(observerName)")
    }
  }
  
  func resignObserver(target: Any, observerName: NotiNames, object: Any?) {
      if let index = registerArray.firstIndex(of: observerName.rawValue) {
        registerArray.remove(at: index)
      
      NotificationCenter.default.removeObserver(
        target,
        name: NSNotification.Name(observerName.rawValue),
        object: object)
      print("remove notification success: \(observerName.rawValue)")
    } else {
      print("no registered notification: \(observerName.rawValue)")
    }
  }
  
  func post(observerName: NotiNames, object: Any?, userInfo: [AnyHashable: Any]? = nil) {
    if registerArray.contains(observerName.rawValue) {
      NotificationCenter.default.post(
        name: NSNotification.Name(observerName.rawValue),
        object: object,
        userInfo: userInfo)
    } else {
      print("post failed\nreason: no registered \(observerName.rawValue) notification")
    }
  }
  
  private init() {}
}
