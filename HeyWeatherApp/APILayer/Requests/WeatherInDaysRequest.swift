//
//  WeatherInDaysRequest.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import YALAPIClient
import Alamofire

class WeatherInDaysRequest: APIRequest, SerializationRule {

  let path: String = "/forecast/daily"
  let parameters: [String: Any]?

  private var days: Int = 0

  init(days: Int) {
    self.days = days
    parameters = ["key": RequestAPI.apiKey,
                  "city": "Dnipro",
                  "days": "\(days)"]
  }

  func serializationRule(for data: Any?) -> [String: Any]? {
    guard let result = data as? [String: Any] else { return nil }
    return result
  }

}
