//
//  UIViewControllerExtension.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIViewController {
  func setupBroccoliNavigationBar(title: String) {
    self.title = title
    
    navigationController?.do({
      $0.navigationBar.barTintColor = .kurlyMainPurple
      $0.navigationBar.tintColor = .white
      $0.navigationBar.barStyle = .black
      $0.navigationBar.isTranslucent = false
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    })
  }
  
  func setupSubNavigationBar(title: String) {
    self.title = title
    
    navigationController?.do({
      $0.navigationBar.tintColor = .black
      $0.navigationBar.barTintColor = .white
      $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    })
  }
  
  @objc
  fileprivate func presentCartViewController() {
    let cartViewController = UINavigationController(rootViewController: CartViewController()).then {
      $0.modalPresentationStyle = .overFullScreen
    }
    
    present(cartViewController, animated: true)
  }
  
  func addNavigationBarCartButton() {
    let cartButton = UIButton(type: .system).then {
      $0.tintColor = .white
      $0.setImage(UIImage(systemName: "cart.fill"), for: .normal)
      
      $0.addTarget(self, action: #selector(presentCartViewController), for: .touchUpInside)
    }
    
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartButton)
  }
}
