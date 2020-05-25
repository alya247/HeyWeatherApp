//
//  WeatherLoader.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

class WeatherLoader {

  unowned private var weatherManager: WeatherManager

  init(weatherManager: WeatherManager) {
    self.weatherManager = weatherManager
  }

  func loadWeather(completion: @escaping ((Bool) -> ())) {
      let group = DispatchGroup()
      var errorWasOccurred = false

    group.enter()
    RequestAPI.requestCurrentWeather() { [weak self] weather in
      group.leave()
      guard let value = weather?.value else { return }
      errorWasOccurred = weather == nil || errorWasOccurred
      self?.weatherManager.setCurrentWeather(value)
    }

    group.enter()
    RequestAPI.requestWeatherInDays(daysCount: PeriodSelectorType.week.daysCount) { [weak self] weather in
      group.leave()
      guard let value = weather?.value else { return }
      errorWasOccurred = weather == nil || errorWasOccurred
      self?.weatherManager.setWeekWeather(value)
    }

    group.enter()
    RequestAPI.requestWeatherInDays(daysCount: PeriodSelectorType.twoWeeks.daysCount) { [weak self] weather in
      group.leave()
      guard let value = weather?.value else { return }
      errorWasOccurred = weather == nil || errorWasOccurred
      self?.weatherManager.setTwoWeeksWeather(value)
    }

    group.notify(queue: .main) {
        completion(errorWasOccurred)
      }
    }

}
