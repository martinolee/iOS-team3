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
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = HomeViewController()
        let navi = UINavigationController(rootViewController: vc)
        navi.navigationBar.barTintColor = .purple
        navi.navigationBar.barStyle = .black
        navi.navigationBar.titleTextAttributes = [
          .foregroundColor : UIColor.white
        ]
        
        window?.rootViewController = navi
        
        window?.makeKeyAndVisible()
        return true
    }


}

