//
//  DayInfo.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Core

struct DayInfo {

  var minTemperature: String = ""
  var maxTemperature: String = ""
  var windSpeed: String = ""
  var weatherIcon: UIImage?
  var averageTemperature: String = ""

  init(model: WeatherDayModel) {
    self.minTemperature = model.minTemperature.flatMap { "\($0.rounded()) \(WeatherSign.temperature.sign)" } ?? ""
    self.maxTemperature = model.maxTemperature.flatMap { "\($0.rounded()) \(WeatherSign.temperature.sign)" } ?? ""
    self.windSpeed = model.windSpeed.flatMap { "\($0.rounded()) \(WeatherSign.windSpeed.sign)" } ?? ""

    let averageValue = (model.minTemperature ?? 0) + (model.maxTemperature ?? 0) / 2
    self.averageTemperature = "\(averageValue.rounded()) \(WeatherSign.temperature.sign)"

    let iconCode = model.condition?.iconCode ?? ""
    self.weatherIcon = UIImage(named: iconCode)
  }

}
