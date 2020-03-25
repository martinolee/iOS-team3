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
    let categoryViewController = UINavigationController(rootViewController: CategoryViewController())
    
    let viewControllers = [homeViewController, categoryViewController, myBroccoliViewController]
    
//    navi.navigationBar.barTintColor = #colorLiteral(red: 0.3176470588, green: 0.1529411765, blue: 0.4470588235, alpha: 1)
//    navi.navigationBar.tintColor = .white
//    navi.navigationBar.isTranslucent = false
//    navi.navigationBar.barStyle = .black
//    navi.navigationBar.titleTextAttributes = [
//      .foregroundColor : UIColor.white
//    ]
    
    
    homeViewController.title = "홈"
    categoryViewController.title = "카테고리"
    myBroccoliViewController.title = "마이브로콜리"
    
    tabBarController.viewControllers = viewControllers
    window?.rootViewController = tabBarController
    
    window?.makeKeyAndVisible()
  }
}
