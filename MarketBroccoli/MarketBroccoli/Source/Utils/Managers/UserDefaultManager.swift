//
//  UserDefaultManager.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.

import UIKit

class UserDefaultManager {
  enum Key: String {
    case token, cart, userName
  }
  
  static let shared = UserDefaultManager()
  private init() { }
  
  @discardableResult func set<T>(_ value: T, for key: Key) -> Bool {
    UserDefaults.standard.set(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
    guard UserDefaults.standard.object(forKey: key.rawValue) != nil else { return false }
    return true
  }
  func get(for key: Key) -> Any? {
    UserDefaults.standard.object(forKey: key.rawValue)
  }
}
