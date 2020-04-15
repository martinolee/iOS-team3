//
//  UITableViewExtension.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UITableView {
  func register<HeaderFooter>(headerFooter: HeaderFooter.Type) where HeaderFooter: UITableViewHeaderFooterView {
    register(headerFooter, forHeaderFooterViewReuseIdentifier: headerFooter.identifier)
  }
  
  func register<Cell>(cell: Cell.Type,
                      forCellReuseIdentifier reuseIdentifier: String = Cell.identifier) where Cell: UITableViewCell {
    register(cell, forCellReuseIdentifier: reuseIdentifier)
  }
  
  func dequeue<Cell>(_ reusableCell: Cell.Type) -> Cell where Cell: UITableViewCell {
    if let cell = dequeueReusableCell(withIdentifier: reusableCell.identifier) as? Cell {
      return cell
    } else {
      fatalError("Identifier required")
    }
  }
}
