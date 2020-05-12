//
//  UITextFieldExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/25.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

extension UITextField {
  func textFieldStyle() {
    self.borderStyle = .roundedRect
    self.clearButtonMode = .whileEditing
  }
  func signupStyle(round: UITextField.BorderStyle, clearButton: UITextField.ViewMode) {
    self.borderStyle = round
    self.clearButtonMode = clearButton
  }
}
