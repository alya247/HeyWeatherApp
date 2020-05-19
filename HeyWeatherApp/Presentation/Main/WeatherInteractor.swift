//
//  WeatherInteractor.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

protocol WeatherInteractorInterface: class {

  func getWeather(for period: PeriodSelectorType)
  func getChartValues(for period: PeriodSelectorType) -> [BarChartValue]
}

class WeatherInteractor {

  private let presenter: WeatherPresenterInterface
  private let errorWasOccurred: Bool
  private var weatherManager: WeatherManager

  init(presenter: WeatherPresenterInterface, weatherManager: WeatherManager = WeatherManager(), errorWasOccurred: Bool = false) {
    self.presenter = presenter
    self.weatherManager = weatherManager
    self.errorWasOccurred = errorWasOccurred
  }

}

extension WeatherInteractor: WeatherInteractorInterface {

  func getWeather(for period: PeriodSelectorType) {
    if errorWasOccurred {
      presenter.errorWasOccurred()
    }

    switch period {
    case .current:
      let weather = weatherManager.getCurrentWeather()
      presenter.presentCurrentWeather(weather)

    case .week:
      let weather = weatherManager.getWeekWeather()
      presenter.presentWeekWeather(weather)

    case .twoWeeks:
      let weather = weatherManager.getTwoWeeksWeather()
      presenter.presentTwoWeekWeather(weather)
    }
  }

  func getChartValues(for period: PeriodSelectorType) -> [BarChartValue] {
    switch period {
    case .week:
      return weatherManager.weekChartValues

    case .twoWeeks:
      return weatherManager.twoWeekChartValues

    default:
      return []
    }
  }

}
