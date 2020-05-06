//
//  WeatherDayModel.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

struct WeatherDayModel: Codable {

  var minTemperature: CGFloat?
  var maxTemperature: CGFloat?
  var windSpeed: CGFloat?
  var condition: WeatherCondition?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    minTemperature = try container.decode(CGFloat.self, forKey: .minTemperature)
    maxTemperature = try container.decode(CGFloat.self, forKey: .maxTemperature)
    windSpeed = try container.decode(CGFloat.self, forKey: .windSpeed)
    condition = try container.decode(WeatherCondition.self, forKey: .condition)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(minTemperature, forKey: .minTemperature)
    try container.encode(maxTemperature, forKey: .maxTemperature)
    try container.encode(windSpeed, forKey: .windSpeed)
    try container.encode(condition, forKey: .condition)
  }

  enum CodingKeys: String, CodingKey {
    case minTemperature = "min_temp"
    case maxTemperature = "max_temp"
    case windSpeed = "wind_spd"
    case condition = "weather"
  }

}
