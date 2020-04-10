//
//  DetailViewController.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/02.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  private let rootView = DetailRootView()
  
  override func loadView() {
    view = rootView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    ObserverManager.shared.registerObserver(
      target: self, selector: #selector(receiveNotification(_:)), observerName: .imageTouched, object: nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    ObserverManager.shared.resignObserver(
      target: self,
      observerName: .imageTouched,
      object: nil)
  }
}

extension DetailViewController {
  @objc private func receiveNotification(_ notification: Notification) {
    guard let image = notification.userInfo?["image"] as? UIImage else { return }
    let popupImageVC = PopImageViewController()
    popupImageVC.modalPresentationStyle = .fullScreen
    popupImageVC.configure(image: image)
    self.present(popupImageVC, animated: true)
  }
}
