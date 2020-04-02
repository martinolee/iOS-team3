//
//  HomeViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  let rootView = HomeRootView()
  
  override func loadView() {
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    registerObserver()
    self.addNavigationBarCartButton()
    self.setupBroccoliNavigationBar(title: "마켓브로콜리")
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    resignObserver()
  }
}

extension HomeViewController {
  private func registerObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveNotification(_:)), name: NSNotification.Name("ProductTouched"), object: nil)
    print("add ProductTouched notification")
  }
  
  private func resignObserver() {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ProductTouched"), object: nil)
    print("remove ProductTouched notification")
  }
  
  @objc private func didReceiveNotification(_ notification: Notification) {
    print(notification)
  }
}
