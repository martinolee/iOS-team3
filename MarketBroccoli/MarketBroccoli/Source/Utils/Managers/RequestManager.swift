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
  case main
  case new
  case best
  case discount
  
  var endPoint: String {
    switch self {
    case .main:
      return baseUrl + "/kurly/main/"
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
  
  func homeRequest(
    url: RequestHome,
    method requestMethod: HTTPMethod,
    completion: @escaping (Result<MainModel, AFError>) -> Void) {
    AF.request(url.endPoint, method: requestMethod)
      .validate(statusCode: [200])
      .responseDecodable(of: MainModel.self) { res in
        completion(res.result)
    }
  }
  
  private init() {}
 }
