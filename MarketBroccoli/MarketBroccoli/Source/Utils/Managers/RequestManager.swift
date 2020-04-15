 //
 //  RequestManager.swift
 //  MarketBroccoli
 //
 //  Created by Hongdonghyun on 2020/04/10.
 //  Copyright © 2020 Team3. All rights reserved.
 //
 
 import Foundation
 import Alamofire
 
 protocol RequestProtocol {
  var baseUrl: String { get }
  var endPoint: String { get }
  var loginToken: String? { get }
 }
 
 extension RequestProtocol {
  var baseUrl: String { "http://15.164.49.32" }
  var loginToken: String? { "TOKEN" }
 }
 
 enum RequestHome: RequestProtocol {
  case mainImages
  case md
  case recommendation
  case new
  case best
  case discount
  
  var endPoint: String {
    switch self {
    case .mainImages:
      return baseUrl + "/kurly/images/"
    case .md:
      return baseUrl + "/kurly/md/"
    case .recommendation:
      return baseUrl + "/kurly/recommend/"
    case .new:
      return baseUrl + "/kurly/new/"
    case .best:
      return baseUrl + "/kurly/best/"
    case .discount:
      return baseUrl + "/kurly/discount/"
    }
  }
 }
 
 class RequestManager {
  static let shared = RequestManager()
  
  func homeImageRequest(
    completion: @escaping (Result<HomeImages, AFError>) -> Void) {
    AF.request(
      RequestHome.mainImages.endPoint,
      method: .get
    ).validate(statusCode: [200])
      .responseDecodable(of: HomeImages.self) { res in
        completion(res.result)
    }
  }
  
  func MDRequest(
    count: Int? = nil,
    completion: @escaping (Result<MDItems, AFError>) -> Void) {
    if let count = count {
      AF.request(
        RequestHome.md.endPoint,
        method: .get,
        parameters: HomeGetQueryModel(count: count),
        encoder: URLEncodedFormParameterEncoder.default
      ).validate(statusCode: [200])
        .responseDecodable(of: MDItems.self) { res in
          completion(res.result)
      }
    } else {
      AF.request(
        RequestHome.md.endPoint,
        method: .get
      ).validate(statusCode: [200])
        .responseDecodable(of: MDItems.self) { res in
          completion(res.result)
      }
    }
  }
  
  func homeRequest(
    url: RequestHome,
    method requestMethod: HTTPMethod,
    count: Int? = nil,
    completion: @escaping (Result<HomeItems, AFError>) -> Void) {
    if let count = count {
      AF.request(
        url.endPoint,
        method: requestMethod,
        parameters: HomeGetQueryModel(count: count),
        encoder: URLEncodedFormParameterEncoder.default
      ).validate(statusCode: [200])
        .responseDecodable(of: HomeItems.self) { res in
          completion(res.result)
      }
    } else {
      AF.request(
        url.endPoint,
        method: requestMethod
      ).validate(statusCode: [200])
        .responseDecodable(of: HomeItems.self) { res in
          completion(res.result)
      }
    }
  }
  
  private init() {}
 }
