//
//  WeatherModel.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

struct WeatherModel: Codable {

  var sunrise: String?
  var sunset: String?
  var city: String?
  var countryCode: String?
  var windSpeed: Float?
  var temperature: Float?
  var feelTemperature: Float?
  var humidity: Float?
  var condition: WeatherCondition?

  enum CodingKeys: String, CodingKey {
    case sunrise
    case sunset
    case city = "cityName"
    case countryCode = "countryCode"
    case windSpeed = "windSpd"
    case temperature = "temp"
    case feelTemperature = "appTemp"
    case humidity = "rh"
    case condition = "weather"
  }

}
