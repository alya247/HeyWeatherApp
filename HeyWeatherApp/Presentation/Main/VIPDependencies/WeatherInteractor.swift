//
//  WeatherInteractor.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherInteractorInterface: class {

  var currentWeather: Observable<WeatherInfo?> { get }
  var periodWeather: Observable<(model: DaysInfo?, type: PeriodSelectorType)> { get }
  var barChartValues: Observable<[BarChartValue]> { get }
  var coordinate: Observable<String?> { get }
  func getWeather(for period: PeriodSelectorType)
  func reloadWeatherIfNeeded()

}

class WeatherInteractor {

  var currentWeather: Observable<WeatherInfo?> {
    return presenter.currentWeather.asObservable()
  }

  var periodWeather: Observable<(model: DaysInfo?, type: PeriodSelectorType)> {
    return presenter.periodWeather.asObservable()
  }

  var barChartValues: Observable<[BarChartValue]> {
    return chartValues.asObservable()
  }

  var coordinate: Observable<String?> {
    return weatherManager.locationManager.coordinateSubject.asObservable()
  }

  private let presenter: WeatherPresenterInterface
  private let errorWasOccurred: Bool
  private var weatherManager: WeatherManager
  private var chartValues = BehaviorSubject<[BarChartValue]>(value: [])

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
      chartValues.onNext([])

    case .week:
      let weather = weatherManager.getWeekWeather()
      presenter.presentWeekWeather(weather)
      chartValues.onNext(weatherManager.weekChartValues)

    case .twoWeeks:
      let weather = weatherManager.getTwoWeeksWeather()
      presenter.presentTwoWeekWeather(weather)
      chartValues.onNext(weatherManager.twoWeekChartValues)
    }
  }

  func reloadWeatherIfNeeded() {
    guard weatherManager.shouldReloadWeather else { return }
    weatherManager.reloadWeather { [weak self] _ in
      self?.presenter.weatherDidLoad()
    }
  }

}
