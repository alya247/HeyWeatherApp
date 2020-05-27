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

  init(days: Int, coordinate: Coordinate) {
    self.days = days
    parameters = ["key": RequestAPI.apiKey,
                  "days": "\(days)",
                  "lat": "\(coordinate.lat)",
                  "lon": "\(coordinate.lon)"]
  }

  func serializationRule(for data: Any?) -> [String: Any]? {
    guard let result = data as? [String: Any] else { return nil }
    return result
  }

}
