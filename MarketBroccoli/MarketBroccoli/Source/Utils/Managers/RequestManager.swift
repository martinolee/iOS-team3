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

 enum RequestSignup: RequestProtocol {
  case duplicate
  case MTokenCreate
  case MTokenAuth
  case accounts
  case authToken
  
  var endPoint: String {
    switch self {
    case .duplicate:
      return baseUrl + "/accounts/duplicates/"
    case .MTokenCreate:
      return baseUrl + "/accounts/m-token-create/"
    case .MTokenAuth:
      return baseUrl + "/accounts/m-token-auth/"
    case .accounts:
      return baseUrl + "/accounts/"
    case .authToken:
      return baseUrl + "/accounts/auth-token/"
    }
  }
 }
 
// class SignupRequestManager {
//  static let shared = SignupRequestManager()
//  
//  func signUpRequest(
//    url: RequestSignup,
//    method requestMethod: HTTPMethod,
//    encoder: ParameterEncoder,
//    headers: [String: String],
//    completion: @escaping (Result<MainModel, AFError>) -> Void) {
//    AF.request(url.endPoint, method: requestMethod)
//      .validate(statusCode: [200])
//      .responseDecodable { res in
//        completion(res.result)
//    }
//  }
//    private init() {}
// }
