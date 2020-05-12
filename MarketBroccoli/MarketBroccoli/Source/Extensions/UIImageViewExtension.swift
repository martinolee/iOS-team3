//
//  UIImageViewExtension.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/10.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit
import Accelerate

extension UIImageView {
  func setImage(urlString: String) {
    let url = URL(string: urlString)
    self.kf.setImage(with: url)
  }
}

extension UIImage {
  public func resized(to targetSize: CGSize) -> UIImage? {
    guard let cgImage = self.cgImage else { return self }
    
    var format = vImage_CGImageFormat(
      bitsPerComponent: UInt32(cgImage.bitsPerComponent),
      bitsPerPixel: UInt32(cgImage.bitsPerPixel), colorSpace: nil,
      bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
      version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
    var sourceBuffer = vImage_Buffer()
    defer {
      sourceBuffer.data.deallocate()
    }
    
    var error = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
    guard error == kvImageNoError else { return self }
    
    // create a destination buffer
    let destWidth = Int(targetSize.width)
    let destHeight = Int(targetSize.height)
    let bytesPerPixel = cgImage.bitsPerPixel / 8
    let destBytesPerRow = destWidth * bytesPerPixel
    let destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
    defer {
      destData.deallocate()
    }
    
    var destBuffer = vImage_Buffer(
      data: destData,
      height: vImagePixelCount(destHeight),
      width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
    
    // scale the image
    error = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
    guard error == kvImageNoError else { return self }
    
    // create a CGImage from vImage_Buffer
    let destCGImage = vImageCreateCGImageFromBuffer(
      &destBuffer, &format, nil,
      nil, numericCast(kvImageNoFlags), &error)?.takeRetainedValue()
    guard error == kvImageNoError else { return self }
    
    // create a UIImage
    let resizedImage = destCGImage.flatMap { UIImage(cgImage: $0, scale: 0.0, orientation: self.imageOrientation) }
    return resizedImage
  }
}
