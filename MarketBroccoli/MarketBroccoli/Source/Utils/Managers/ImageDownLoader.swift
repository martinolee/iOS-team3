//
//  ImageDownLoader.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/17.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation
import Kingfisher

func downloadImage(with URLString: String, completion: @escaping (KFCrossPlatformImage?) -> Void) {
  guard let url = URL(string: URLString) else { return }
  KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: { image, error, cacheType, imageURL in
    completion(image)
  })
}
