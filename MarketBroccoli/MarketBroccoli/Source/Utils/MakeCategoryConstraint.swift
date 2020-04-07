//
//  MakeCategoryConstraint.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/03.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

func makeCategoryConstraint(target: UIView, categories: [UIView]) {
  for idx in categories.indices {
    target.addSubview(categories[idx])
    categories[idx].snp.makeConstraints {
      if idx == 0 {
        $0.top.leading.bottom.equalToSuperview()
      } else if idx == categories.endIndex - 1 {
        $0.leading.equalTo(categories[idx - 1].snp.trailing)
        $0.top.bottom.trailing.equalToSuperview()
      } else {
        $0.leading.equalTo(categories[idx - 1].snp.trailing)
        $0.top.bottom.equalToSuperview()
      }
      $0.width.height.equalTo(target)
    }
  }
}
