//
//  WeatherLoader.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

typealias Coordinate = (lat: Double, lon: Double)

public class WeatherLoader {

  unowned private var weatherManager: WeatherManager

  public init(weatherManager: WeatherManager) {
    self.weatherManager = weatherManager
  }

  func loadWeather(coordinate: Coordinate, completion: @escaping ((Bool) -> ())) {
      let group = DispatchGroup()
      var errorWasOccurred = false

    group.enter()
    RequestAPI.requestCurrentWeather(coordinate: coordinate) { [weak self] weather in
      group.leave()
      guard let value = weather?.value else { return }
      errorWasOccurred = weather == nil || errorWasOccurred
      self?.weatherManager.setCurrentWeather(value)
    }

    group.enter()
    RequestAPI.requestWeatherInDays(daysCount: PeriodSelectorType.week.daysCount, coordinate: coordinate) { [weak self] weather in
      group.leave()
      guard let value = weather?.value else { return }
      errorWasOccurred = weather == nil || errorWasOccurred
      self?.weatherManager.setWeekWeather(value)
    }

    group.enter()
    RequestAPI.requestWeatherInDays(daysCount: PeriodSelectorType.twoWeeks.daysCount, coordinate: coordinate) { [weak self] weather in
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
