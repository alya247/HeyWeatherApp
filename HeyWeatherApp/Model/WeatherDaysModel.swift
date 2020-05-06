//
//  WeatherDaysModel.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

struct WeatherDaysModel: Codable {

  var city: String?
  var countryCode: String?
  var days: [WeatherDayModel] = []

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    city = try container.decode(String.self, forKey: .city)
    countryCode = try container.decode(String.self, forKey: .countryCode)
    days = try container.decode([WeatherDayModel].self, forKey: .days)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(city, forKey: .city)
    try container.encode(countryCode, forKey: .countryCode)
    try container.encode(days, forKey: .days)
  }

  enum CodingKeys: String, CodingKey {
    case city = "city_name"
    case countryCode = "country_code"
    case days = "data"
  }

}
