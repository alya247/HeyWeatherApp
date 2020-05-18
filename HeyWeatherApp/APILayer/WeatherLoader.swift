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
        completion(errorWasOccurred)
      }
    }

}
