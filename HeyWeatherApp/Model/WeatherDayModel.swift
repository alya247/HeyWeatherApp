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

  enum CodingKeys: String, CodingKey {
    case minTemperature = "min_temp"
    case maxTemperature = "max_temp"
    case windSpeed = "wind_spd"
    case condition = "weather"
  }

}
