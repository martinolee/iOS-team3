//
//  AppDelegate.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setupRootViewController()
    
    return true
  }
  
  private func setupRootViewController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    
    let tabBarController = UITabBarController()
    let homeViewController = UINavigationController(rootViewController: HomeViewController())
    let myBroccoliViewController = UINavigationController(rootViewController: SettingsViewController())
    let viewControllers = [homeViewController, myBroccoliViewController]
    
    homeViewController.title = "홈"
    myBroccoliViewController.title = "마이브로콜리"
    
    tabBarController.viewControllers = viewControllers
    window?.rootViewController = tabBarController
    
//    let vc = SignUpViewController()
    
    window?.makeKeyAndVisible()
  }
}
