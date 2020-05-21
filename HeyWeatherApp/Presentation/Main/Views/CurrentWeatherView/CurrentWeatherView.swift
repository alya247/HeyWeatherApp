//
//  CurrentWeatherView.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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

  private let bag = DisposeBag()

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialSetup()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialSetup()
  }

  func bind(to weather: Observable<WeatherInfo?>) {
    weather.map { $0?.temperature }.bind(to: temperatureLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.feelTemperature }.bind(to: feelTemperatureLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.sunrise }.bind(to: sunriseLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.sunset }.bind(to: sunsetLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.city }.bind(to: cityLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.windSpeed }.bind(to: windSpeedLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.humidity }.bind(to: humidityLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.weatherDescription }.bind(to: descriptionLabel.rx.text ).disposed(by: bag)
    weather.map { $0?.weatherIcon }.bind(to: iconImageView.rx.image ).disposed(by: bag)
  }

}
