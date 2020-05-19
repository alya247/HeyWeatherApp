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
  var windSpeed: CGFloat?
  var temperature: CGFloat?
  var feelTemperature: CGFloat?
  var humidity: CGFloat?
  var condition: WeatherCondition?

  enum CodingKeys: String, CodingKey {
    case sunrise
    case sunset
    case city = "city_name"
    case countryCode = "country_code"
    case windSpeed = "wind_spd"
    case temperature = "temp"
    case feelTemperature = "app_temp"
    case humidity = "rh"
    case condition = "weather"
  }

}
