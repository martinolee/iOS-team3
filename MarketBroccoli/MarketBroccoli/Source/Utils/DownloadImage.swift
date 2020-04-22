//
//  DownloadImage.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

func downloadImage(imageURL: String) -> UIImage? {
  guard let url = URL(string: imageURL) else { return nil }
  if let data = try? Data(contentsOf: url) {
    return UIImage(data: data)
  }
  return nil
}
