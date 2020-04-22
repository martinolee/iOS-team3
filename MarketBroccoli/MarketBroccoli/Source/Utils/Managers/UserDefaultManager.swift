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
  
  func remove(for key: Key) {
    let empty: Any? = nil
    
    set(empty, for: key)
  }
  
  func set<T>(_ value: T?, for key: Key) {
    UserDefaults.standard.set(value, forKey: key.rawValue)
    UserDefaults.standard.synchronize()
  }
  
  func get(for key: Key) -> Any? {
    UserDefaults.standard.object(forKey: key.rawValue)
  }
  
  func isLogin() -> Bool {
    UserDefaults.standard.object(forKey: Key.token.rawValue) != nil
  }
  
  private init() { }
}
