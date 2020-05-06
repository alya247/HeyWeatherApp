//
//  WeatherInDaysRequest.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

class WeatherInDaysRequest: Request {

  typealias ResponseModel = WeatherDaysModel

  var path: String {
    return "/forecast/daily"
  }

  var parameters: [String: String] {
    return ["key": apiKey,
            "city": "Dnipro",
            "days": "\(days)"]
  }

  private var days: Int = 0

  init(days: Int) {
    self.days = days
  }

  func serializationRule(for data: Any?) -> [String: Any]? {
    guard let result = data as? [String: Any] else { return nil }
    return result
  }
  
}
