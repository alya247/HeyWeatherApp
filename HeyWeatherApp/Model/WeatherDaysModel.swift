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

  enum CodingKeys: String, CodingKey {
    case city = "cityName"
    case countryCode = "countryCode"
    case days = "data"
  }

}
