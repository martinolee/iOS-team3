//
//  UIDeviceExtension.swift
//  MarketBroccoli
//
//  Created by Soohan Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UIDevice {
  static var hasNotch: Bool {
    let bottom = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0
    return bottom > 0
  }
}
