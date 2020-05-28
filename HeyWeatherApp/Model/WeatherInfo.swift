//
//  WeatherInfo.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Core

struct WeatherInfo {

  var sunrise: String = ""
  var sunset: String = ""
  var city: String = ""
  var windSpeed: String = ""
  var temperature: String = ""
  var feelTemperature: String = ""
  var humidity: String = ""
  var weatherDescription: String = ""
  var weatherIcon: UIImage?

  init(model: WeatherModel) {
    self.sunrise = model.sunrise?.convertedTimeZoneTime() ?? ""
    self.sunset = model.sunset?.convertedTimeZoneTime() ?? ""
    let countryCode = model.countryCode.flatMap({ ", \($0)" }) ?? ""
    self.city = model.city.flatMap({ "\($0)\(countryCode)" }) ?? ""
    self.windSpeed = model.windSpeed.flatMap { "\($0.rounded()) \(WeatherSign.windSpeed.sign)" } ?? ""
    self.temperature = model.temperature.flatMap { "\($0.rounded()) \(WeatherSign.temperature.sign)" } ?? ""
    self.feelTemperature = model.feelTemperature.flatMap { "\($0.rounded()) \(WeatherSign.temperature.sign)" } ?? ""
    self.humidity = model.humidity.flatMap { "\($0.rounded()) \(WeatherSign.humidity.sign)" } ?? ""
    self.weatherDescription = model.condition?.description ?? ""
    let iconCode = model.condition?.iconCode ?? ""
    self.weatherIcon = UIImage(named: iconCode)
  }

}
