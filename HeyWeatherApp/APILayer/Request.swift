//
//  Request.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

protocol Request {

  associatedtype ResponseModel: Decodable

  var path: String { get }
  var apiKey: String { get }
  var version: String { get }
  var parameters: [String: String] { get }
  func serializationRule(for data: Any?) -> [String: Any]?
}

extension Request {

  var apiKey: String {
    return RequestAPI.apiKey
  }

  var version: String {
    return "v2.0"
  }

}
