//
//  UITableViewCellExtension.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/23.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

protocol Identifiable {
  static var identifier: String { get }
}

extension Identifiable {
  static var identifier: String { String(describing: self) }
}

extension UITableViewCell: Identifiable { }
