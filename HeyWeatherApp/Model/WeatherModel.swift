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

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    sunrise = try container.decode(String.self, forKey: .sunrise)
    sunset = try container.decode(String.self, forKey: .sunset)
    city = try container.decode(String.self, forKey: .city)
    countryCode = try container.decode(String.self, forKey: .countryCode)
    windSpeed = try container.decode(CGFloat.self, forKey: .windSpeed)
    temperature = try container.decode(CGFloat.self, forKey: .temperature)
    feelTemperature = try container.decode(CGFloat.self, forKey: .feelTemperature)
    humidity = try container.decode(CGFloat.self, forKey: .humidity)
    condition = try container.decode(WeatherCondition.self, forKey: .condition)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(sunrise, forKey: .sunrise)
    try container.encode(sunset, forKey: .sunset)
    try container.encode(city, forKey: .city)
    try container.encode(countryCode, forKey: .countryCode)
    try container.encode(windSpeed, forKey: .windSpeed)
    try container.encode(temperature, forKey: .temperature)
    try container.encode(feelTemperature, forKey: .feelTemperature)
    try container.encode(humidity, forKey: .humidity)
    try container.encode(condition, forKey: .condition)
  }

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
