//
//  CurrentWeatherRequest.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import YALAPIClient
import Alamofire

class CurrentWeatherRequest: APIRequest, SerializationRule {

  let path: String = "/current"
  let parameters: [String: Any]?

  init(coordinate: Coordinate) {
    parameters = ["key": RequestAPI.apiKey,
                  "lat": "\(coordinate.lat)",
                  "lon": "\(coordinate.lon)"]
  }

  func serializationRule(for data: Any?) -> [String: Any]? {
    guard let result = data as? [String: Any], let data = result["data"] as? [[String: Any]], !data.isEmpty else {
      return nil
    }
    return data[0]
  }

}
