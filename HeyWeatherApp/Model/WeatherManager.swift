//
//  WeatherManager.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

class WeatherManager {

  lazy var weekChartValues: [BarChartValue] = {
    let weather = getWeekWeather()
    return weather?.days.map { BarChartValue(max: $0.maxTemperature ?? 0, min: $0.minTemperature ?? 0) } ?? []
  }()

  lazy var twoWeekChartValues: [BarChartValue] = {
    let weather = getTwoWeeksWeather()
    return weather?.days.map { BarChartValue(max: $0.maxTemperature ?? 0, min: $0.minTemperature ?? 0) } ?? []
  }()

  private var currentWeather: WeatherModel?
  private var weekWeather: WeatherDaysModel?
  private var twoWeeksWeather: WeatherDaysModel?

  // MARK:- Setters

  func setCurrentWeather(_ weather: WeatherModel?) {
    currentWeather = weather
    saveWeather(weather, for: .current)
  }

  func setWeekWeather(_ weather: WeatherDaysModel?) {
    weekWeather = weather
    saveWeather(weather, for: .week)
  }

  func setTwoWeeksWeather(_ weather: WeatherDaysModel?) {
    twoWeeksWeather = weather
    saveWeather(weather, for: .twoWeeks)
  }

  // MARK:- Getters

  func getCurrentWeather() -> WeatherModel? {
    if let weather = currentWeather {
      return weather
    } else {
      return read(PreserveKeyComponent.current.rawValue, as: WeatherModel.self)
    }
  }

  func getWeekWeather() -> WeatherDaysModel? {
    if let weather = weekWeather {
      return weather
    } else {
      return read(PreserveKeyComponent.week.rawValue, as: WeatherDaysModel.self)
    }
  }

  func getTwoWeeksWeather() -> WeatherDaysModel? {
    if let weather = twoWeeksWeather {
      return weather
    } else {
      return read(PreserveKeyComponent.twoWeeks.rawValue, as: WeatherDaysModel.self)
    }
  }

}

// MARK:- Private Methods

extension WeatherManager {

  private func saveWeather<T: Encodable>(_ weather: T?, for period: PeriodSelectorType) {
    guard let weather = weather else { return }
    switch period {
    case .current:
      preserve(weather, as: PreserveKeyComponent.current.rawValue)
    case .week:
      preserve(weather, as: PreserveKeyComponent.week.rawValue)
    case .twoWeeks:
      preserve(weather, as: PreserveKeyComponent.twoWeeks.rawValue)
    }
  }

  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  private func preserve<T: Encodable>(_ object: T, as fileName: String) {
    let url = getDocumentsDirectory().appendingPathComponent(fileName, isDirectory: false)

    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(object)
      if FileManager.default.fileExists(atPath: url.path) {
        try FileManager.default.removeItem(at: url)
      }
      FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    } catch {
      fatalError(error.localizedDescription)
    }
  }

  private func read<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
    let url = getDocumentsDirectory().appendingPathComponent(fileName, isDirectory: false)

    if !FileManager.default.fileExists(atPath: url.path) {
      return nil
    }
    if let data = FileManager.default.contents(atPath: url.path) {
      let decoder = JSONDecoder()
      do {
        let model = try decoder.decode(type, from: data)
        return model
      } catch {
        return nil
      }
    } else {
      return nil
    }
  }
}

private extension WeatherManager {

  enum PreserveKeyComponent: String {
    case current = "currentWeather.json"
    case week = "weekWeather.json"
    case twoWeeks = "twoWeeksWeather.json"
  }

}
