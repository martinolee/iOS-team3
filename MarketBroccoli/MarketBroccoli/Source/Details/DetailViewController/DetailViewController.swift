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
  
  private var productId: Int? {
    willSet {
      if let productId = newValue {
        RequestManager.shared.detailRequest(url: .detail, method: .get, productId: productId) { [weak self] in
          guard let self = self else { return }
          switch $0 {
          case .success(let data):
            self.model = data
          case .failure(let error):
            print(error)
          }
        }
      }
    }
  }
  private var model: ProductModel? {
    didSet {
      guard let tableView = self.rootView.scrollView.subviews.first as? DetailDescriptionTableView else { return }
      tableView.reloadData()
      print("reload")
    }
  }
  
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

// MARK: - ACTIONS
extension DetailViewController {
  func configure(productId id: Int) {
    productId = id
  }
  
  @objc private func receiveNotification(_ notification: Notification) {
    guard let image = notification.userInfo?["image"] as? UIImage else { return }
    let popupImageVC = PopImageViewController()
    popupImageVC.modalPresentationStyle = .fullScreen
    popupImageVC.configure(image: image)
    self.present(popupImageVC, animated: true)
  }
}

// MARK: - DataSource
extension DetailViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int { 2 }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let model = model else { return UITableViewCell() }
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeue(DetailDescriptionTopTableCell.self)
      cell.configure(detail: model)
      return cell
    case 1:
      let cell = tableView.dequeue(DetailDescriptionBottomTableCell.self)
      cell.configure(detail: model)
      return cell
    default:
      fatalError()
    }
  }
}
