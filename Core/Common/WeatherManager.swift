//
//  WeatherManager.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

public class WeatherManager: PersistenceHolder {

  public lazy var weekChartValues: [BarChartValue] = {
    let weather = getWeekWeather()
    return weather?.days.map { BarChartValue(max: CGFloat($0.maxTemperature ?? 0), min: CGFloat($0.minTemperature ?? 0)) } ?? []
  }()

  public lazy var twoWeekChartValues: [BarChartValue] = {
    let weather = getTwoWeeksWeather()
    return weather?.days.map { BarChartValue(max: CGFloat($0.maxTemperature ?? 0), min: CGFloat($0.minTemperature ?? 0)) } ?? []
  }()

  private var currentWeather: WeatherModel?
  private var weekWeather: WeatherDaysModel?
  private var twoWeeksWeather: WeatherDaysModel?

  public var weatherLoader: WeatherLoader!
  public var locationManager: LocationManager!
  public var shouldReloadWeather: Bool {
    return locationManager.shouldReloadWeather
  }

  public init() { }

  public func loadWeather(completion: @escaping ((Bool) -> ())) {
    locationManager.requestLocation { [weak self] coordinate in
      guard let coordinate = coordinate else {
        completion(true)
        return
      }
      let convertedCoordinate = Coordinate(lat: Double(coordinate.latitude), lon: Double(coordinate.longitude))
      self?.weatherLoader.loadWeather(coordinate: convertedCoordinate, completion: completion)
    }
  }

  public func reloadWeather(completion: @escaping ((Bool) -> ())) {
    guard let coordinate = locationManager.selectedCoordinate else {
      completion(true)
      return
    }
    let c = Coordinate(lat: Double(coordinate.latitude), lon: Double(coordinate.longitude))
    weatherLoader.loadWeather(coordinate: c, completion: completion)
  }

  // MARK:- Setters

  func setCurrentWeather(_ weather: WeatherModel?) {
    currentWeather = weather
    saveCurrentWeather(weather)
  }

  func setWeekWeather(_ weather: WeatherDaysModel?) {
    weekWeather = weather
    saveDaysWeather(weather, fileName: PreserveKeyComponent.week.rawValue)
  }

  func setTwoWeeksWeather(_ weather: WeatherDaysModel?) {
    twoWeeksWeather = weather
    saveDaysWeather(weather, fileName: PreserveKeyComponent.twoWeeks.rawValue)
  }

  // MARK:- Getters

  public func getCurrentWeather() -> WeatherModel? {
    if let weather = currentWeather {
      return weather
    } else {
      return getCurrentWeather(fileName: PreserveKeyComponent.current.rawValue)
    }
  }

  public func getWeekWeather() -> WeatherDaysModel? {
    if let weather = weekWeather {
      return weather
    } else {
      return getPeriodWeather(fileName: PreserveKeyComponent.week.rawValue)
    }
  }

  public func getTwoWeeksWeather() -> WeatherDaysModel? {
    if let weather = twoWeeksWeather {
      return weather
    } else {
      return getPeriodWeather(fileName: PreserveKeyComponent.twoWeeks.rawValue)
    }
  }

}

// MARK:- Private Methods

extension WeatherManager {

  private func saveCurrentWeather(_ weather: WeatherModel?) {
    guard let weather = weather else { return }
    saveCurrent(weather: weather, fileName: PreserveKeyComponent.current.rawValue)
  }

  private func saveDaysWeather(_ weather: WeatherDaysModel?, fileName: String) {
    guard let weather = weather else { return }
    saveDays(weather: weather, fileName: fileName)
  }

}

extension WeatherManager {

  enum PreserveKeyComponent: String {
    case current = "currentWeather.json"
    case week = "weekWeather.json"
    case twoWeeks = "twoWeeksWeather.json"
    case selectedLocation = "selectedLocation.json"
  }

}

enum IdetificatorsProvider: String {
  case current = "currentID"
  case week = "weekID"
  case twoWeeks = "twoWeeksID"
  case condition = "conditionID"
  case day = "dayID"
}
