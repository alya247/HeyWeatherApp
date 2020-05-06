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

  init?(rawValue: [String: Any]) {
    guard let code = rawValue["icon"] as? String,
      let description = rawValue["description"] as? String else { return nil }
    self.iconCode = code
    self.description = description
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    iconCode = try container.decode(String.self, forKey: .iconCode)
    description = try container.decode(String.self, forKey: .description)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(iconCode, forKey: .iconCode)
    try container.encode(description, forKey: .description)
  }

  enum CodingKeys: String, CodingKey {
    case iconCode = "icon"
    case description
  }
  
}
