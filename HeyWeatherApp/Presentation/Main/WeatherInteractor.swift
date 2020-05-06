//
//  WeatherInteractor.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

protocol WeatherInteractorInterface: class {

  func loadWeather()
  func getWeather(for period: PeriodSelectorType)
  func getChartValues(for period: PeriodSelectorType) -> [BarChartValue]
}

class WeatherInteractor {

  private let presenter: WeatherPresenterInterface
  private var weatherManager: WeatherManager

  init(presenter: WeatherPresenterInterface) {
    self.presenter = presenter
    weatherManager = WeatherManager()
  }

}

extension WeatherInteractor: WeatherInteractorInterface {

  func loadWeather() {
    let group = DispatchGroup()
    var errorWasOccurred = false

    group.enter()
    RequestAPI.requestData(CurrentWeatherRequest()) { [weak self] weather in
      group.leave()
      errorWasOccurred = weather == nil || errorWasOccurred
      self?.weatherManager.setCurrentWeather(weather)
    }

    group.enter()
    RequestAPI.requestData(WeatherInDaysRequest(days: PeriodSelectorType.week.daysCount)) { weather in
      group.leave()
      errorWasOccurred = weather == nil || errorWasOccurred
      self.weatherManager.setWeekWeather(weather)
    }

    group.enter()
    RequestAPI.requestData(WeatherInDaysRequest(days: PeriodSelectorType.twoWeeks.daysCount)) { weather in
      group.leave()
      errorWasOccurred = weather == nil || errorWasOccurred
      self.weatherManager.setTwoWeeksWeather(weather)
    }

    group.notify(queue: .main) {
      if errorWasOccurred {
        self.presenter.errorWasOccurred()
      }
      self.presenter.weatherDidLoad()
    }
  }

  func getWeather(for period: PeriodSelectorType) {
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
