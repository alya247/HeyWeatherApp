//
//  CurrentWeatherView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class CurrentWeatherView: UIView {

  @IBOutlet private var temperatureLabel: UILabel!
  @IBOutlet private var feelTemperatureLabel: UILabel!
  @IBOutlet private var sunriseLabel: UILabel!
  @IBOutlet private var sunsetLabel: UILabel!
  @IBOutlet private var cityLabel: UILabel!
  @IBOutlet private var windSpeedLabel: UILabel!
  @IBOutlet private var humidityLabel: UILabel!
  @IBOutlet private var descriptionLabel: UILabel!
  @IBOutlet private var iconImageView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
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

// MARK:- Private Methods

extension CurrentWeatherView {

  private func setup() {
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
    let contentView = nib.instantiate(withOwner: self, options: nil).first! as! UIView
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }

}
