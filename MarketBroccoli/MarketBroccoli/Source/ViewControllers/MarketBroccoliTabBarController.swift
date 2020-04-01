//
//  MarketBroccoliTabBarController.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class MartketBroccliTabBarController: UITabBarController {
  override func viewDidLoad() {
    setupTabBar()
  }
  
  func setupTabBar() {
    tabBar.tintColor = .kurlyPurple
    tabBar.backgroundColor = .white
    
    let homeViewController = UINavigationController(rootViewController: HomeViewController()).then {
      let unselectedImage = UIImage(systemName: "house")
      let selectedImage = UIImage(systemName: "house.fill")
      
      $0.tabBarItem = UITabBarItem(title: "홈", image: unselectedImage, selectedImage: selectedImage)
    }
    
    let categoryViewController = UINavigationController(rootViewController: CategoryViewController()).then {
      let unselectedImage = UIImage(systemName: "line.horizontal.3")
      let selectedImage = UIImage(systemName: "line.horizontal.3")
      
      $0.tabBarItem = UITabBarItem(title: "카테고리", image: unselectedImage, selectedImage: selectedImage)
    }
    
    let searchViewController = UINavigationController(rootViewController: SearchViewController()).then {
      let unselectedImage = UIImage(systemName: "magnifyingglass")
      let selectedImage = UIImage(systemName: "magnifyingglass")
      
      $0.tabBarItem = UITabBarItem(title: "검색", image: unselectedImage, selectedImage: selectedImage)
    }
    
    let myBroccoliViewController = UINavigationController(rootViewController: SettingsViewController()).then {
      let unselectedImage = UIImage(systemName: "person")
      let selectedImage = UIImage(systemName: "person.fill")
      
      $0.tabBarItem = UITabBarItem(title: "마이브로콜리", image: unselectedImage, selectedImage: selectedImage)
    }
    
    let viewControllers = [homeViewController, categoryViewController, searchViewController, myBroccoliViewController]
    
    self.viewControllers = viewControllers
  }
}
