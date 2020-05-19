//
//  CurrentWeatherView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {

  @IBOutlet private weak var temperatureLabel: UILabel!
  @IBOutlet private weak var feelTemperatureLabel: UILabel!
  @IBOutlet private weak var sunriseLabel: UILabel!
  @IBOutlet private weak var sunsetLabel: UILabel!
  @IBOutlet private weak var cityLabel: UILabel!
  @IBOutlet private weak var windSpeedLabel: UILabel!
  @IBOutlet private weak var humidityLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var iconImageView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialSetup()
  }

  func apply(_ weather: WeatherInfo) {
    temperatureLabel.text = weather.temperature
    feelTemperatureLabel.text = weather.feelTemperature
    sunriseLabel.text = weather.sunrise
    sunsetLabel.text = weather.sunset
    cityLabel.text = weather.city
    windSpeedLabel.text = weather.windSpeed
    humidityLabel.text = weather.humidity
    descriptionLabel.text = weather.weatherDescription
    iconImageView.image = weather.weatherIcon
  }

}
