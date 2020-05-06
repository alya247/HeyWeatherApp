//
//  CurrentWeatherRequest.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

class CurrentWeatherRequest: Request {

  typealias ResponseModel = WeatherModel

  var path: String {
    return "/current"
  }

  var parameters: [String: String] {
    return ["key": apiKey,
            "city": "Dnipro"]
  }

  func serializationRule(for data: Any?) -> [String: Any]? {
    guard let result = data as? [String: Any], let data = result["data"] as? [[String: Any]], !data.isEmpty else {
      return nil
    }
    return data[0]
  }

}
