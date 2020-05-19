//
//  WeatherCondition.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

struct WeatherCondition: Codable {

  var iconCode: String
  var description: String

  enum CodingKeys: String, CodingKey {
    case iconCode = "icon"
    case description
  }
  
}
