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
            guard let detailImage = self.model?.images.first(where: { $0.name == "detail" }) else { return }
            self.rootView.detailImageView.detailImage = detailImage.image
            self.navigationItem.title = self.model?.name
          case .failure(let error):
            print(error)
          }
        }
      }
    }
  }
  open var model: ProductModel? {
    didSet {
      guard let tableView = self.rootView.scrollView.subviews.first as? DetailDescriptionTableView else { return }
      DispatchQueue.main.async {
        self.rootView.scrollView.reloadInputViews()
        tableView.reloadData()
      }
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
    
    ObserverManager.shared.registerObserver(
        target: self, selector: #selector(purchaseBtnTouched(_:)), observerName: .purchaseBtnTouched, object: nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    ObserverManager.shared.resignObserver(
      target: self,
      observerName: .imageTouched,
      object: nil)
    
    ObserverManager.shared.resignObserver(target: self, observerName: .purchaseBtnTouched, object: nil)
  }
}

// MARK: - ACTIONS
extension DetailViewController {
  func configure(productId id: Int) {
    productId = id
  }
  
  @objc private func receiveNotification(_ notification: Notification) {
    guard let image = model?.images.first(where: { $0.name == "detail" }) else { return }
    let popupImageVC = PopImageViewController()
    popupImageVC.modalPresentationStyle = .fullScreen
    popupImageVC.configure(image: image.image)
    self.present(popupImageVC, animated: true)
  }
  
  @objc private func purchaseBtnTouched(_ button: UIButton) {
    let navigationController = UINavigationController(rootViewController: AddProductCartViewController())
    
    present(navigationController, animated: true) {
      navigationController.do {
        guard
          let firstViewController = $0.viewControllers.first as? AddProductCartViewController,
          let id = self.productId,
          let product = self.model
        else { return }
        
        firstViewController.deliver(
          id: id,
          name: product.name,
          price: product.price,
          discountRate: product.discountRate
        )
      }
    }
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
      var images = [String: UIImage]()
      let cell = tableView.dequeue(DetailDescriptionBottomTableCell.self)
      for image in model.images {
        if ["detail", "thumb", "check"].contains(image.name) {
          images[image.name] = downloadImage(imageURL: image.image)
        }
      }
      cell.configure(detail: model, images: images)
      
      return cell
    default:
      fatalError()
    }
  }
}
