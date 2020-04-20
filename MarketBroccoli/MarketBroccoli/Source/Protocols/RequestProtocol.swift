//
//  RequestProtocol.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/04/16.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

protocol RequestProtocol {
 var baseUrl: String { get }
 var endPoint: String { get }
 var loginToken: String? { get }
}

extension RequestProtocol {
 var baseUrl: String { "http://15.164.49.32" }
 var loginToken: String? { "TOKEN" }
}
