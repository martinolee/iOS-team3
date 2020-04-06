//
//  AppDelegate.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Then
import SnapKit

@UIApplicationMain
 class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupRootViewController()
    
    return true
    }
  
  private func setupRootViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let marketBroccoliTabBarController = MartketBroccoliTabBarController()
//    let hong3TestVC = DetailViewController()
    window?.rootViewController = marketBroccoliTabBarController
    window?.makeKeyAndVisible()
  }
}
