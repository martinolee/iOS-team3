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
    ObserverManager.shared.registerObserver(
      target: self, selector: #selector(receiveNotification(_:)), observerName: .productTouched, object: nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    ObserverManager.shared.resignObserver(
      target: self,
      observerName: .productTouched,
      object: nil)
  }
}

extension HomeViewController {
  @objc private func receiveNotification(_ notification: Notification) {
    let detailVC = DetailViewController()
    let barBtnItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    
    detailVC.hidesBottomBarWhenPushed = true
    navigationItem.backBarButtonItem = barBtnItem
    navigationController?.pushViewController(detailVC, animated: true)
  }
}
