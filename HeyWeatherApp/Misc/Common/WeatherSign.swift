//
//  WeatherSign.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

enum WeatherSign {
  case humidity
  case windSpeed
  case temperature

  var sign: String {
    switch self {
    case.humidity: return "%"
    case .windSpeed: return "m/s"
    case .temperature: return "º"
    }
  }
}
