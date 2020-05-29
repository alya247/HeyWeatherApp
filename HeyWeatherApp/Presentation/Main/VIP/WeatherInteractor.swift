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
import Core

typealias BarChartValues = BarChartValue

protocol WeatherInteractorInterface: class {

  var currentWeather: Observable<WeatherInfo?> { get }
  var periodWeather: Observable<(model: DaysInfo?, type: PeriodType)> { get }
  var barChartValues: Observable<[BarChartValues]> { get }
  var coordinate: Observable<String?> { get }
  func loadWeather()
  func getWeather(for period: PeriodType)
  func reloadWeatherIfNeeded()
  func logOut()

}

class WeatherInteractor {

  var currentWeather: Observable<WeatherInfo?> {
    return presenter.currentWeather.asObservable()
  }

  var periodWeather: Observable<(model: DaysInfo?, type: PeriodType)> {
    return presenter.periodWeather.asObservable()
  }

  var barChartValues: Observable<[BarChartValues]> {
    return chartValues.asObservable()
  }

  var coordinate: Observable<String?> {
    return weatherManager.locationManager.coordinateSubject.asObservable()
  }

  private let presenter: WeatherPresenterInterface
  private let errorWasOccurred: Bool
  private let userSessionController: UserSessionController
  private var weatherManager: WeatherManager
  private var chartValues = BehaviorSubject<[BarChartValues]>(value: [])

  init(presenter: WeatherPresenterInterface,
       weatherManager: WeatherManager = WeatherManager(),
       errorWasOccurred: Bool = false,
       userSessionController: UserSessionController) {
    self.presenter = presenter
    self.weatherManager = weatherManager
    self.errorWasOccurred = errorWasOccurred
    self.userSessionController = userSessionController
  }

}

extension WeatherInteractor: WeatherInteractorInterface {

  func loadWeather() {
    weatherManager.loadWeather { [weak self] errorWasOccurred in
      guard errorWasOccurred else {
        self?.presenter.errorWasOccurred()
        return
      }
      self?.presenter.weatherDidLoad()
    }
  }

  func getWeather(for period: PeriodType) {
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

  func logOut() {
    userSessionController.closeSession()
    presenter.userDidLogOut()
  }

}
