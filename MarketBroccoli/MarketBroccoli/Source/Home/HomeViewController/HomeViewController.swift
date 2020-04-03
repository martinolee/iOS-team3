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
    self.addNavigationBarCartButton()
    self.setupBroccoliNavigationBar(title: "마켓브로콜리")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerObserver()
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    resignObserver()
  }
}

extension HomeViewController {
  private func registerObserver() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didReceiveNotification(_:)),
      name: NSNotification.Name("ProductTouched"),
      object: nil)
    print("add ProductTouched notification")
  }
  
  private func resignObserver() {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name("ProductTouched"), object: nil)
    print("remove ProductTouched notification")
  }
  
  @objc private func didReceiveNotification(_ notification: Notification) {
    let detailVC = DetailViewController()
    let barBtnItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    
    detailVC.hidesBottomBarWhenPushed = true
    navigationItem.backBarButtonItem = barBtnItem
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
