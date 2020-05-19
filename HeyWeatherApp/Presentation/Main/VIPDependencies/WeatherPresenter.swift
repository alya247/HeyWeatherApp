//
//  WeatherPresenter.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

protocol WeatherPresenterInterface: class {

  var view: WeatherViewInterface! { get set }
  func weatherDidLoad()
  func errorWasOccurred()
  func presentCurrentWeather(_ weather: WeatherModel?)
  func presentWeekWeather(_ weather: WeatherDaysModel?)
  func presentTwoWeekWeather(_ weather: WeatherDaysModel?)
}

class WeatherPresenter {

  unowned var view: WeatherViewInterface!

}

extension WeatherPresenter: WeatherPresenterInterface {

  func weatherDidLoad() {
    view.weatherDidLoad()
  }

  func errorWasOccurred() {
    view.presentError()
  }

  func presentCurrentWeather(_ weather: WeatherModel?) {
    if let weather = weather {
      let info = WeatherInfo(model: weather)
      view.presentCurrentWeather(info)
    } else {
      view.presentError()
    }
  }

  func presentWeekWeather(_ weather: WeatherDaysModel?) {
    if let weather = weather {
      let info = DaysInfo(model: weather)
      view.presentWeatherByDays(info, type: .week)
    } else {
      view.presentError()
    }
  }

  func presentTwoWeekWeather(_ weather: WeatherDaysModel?) {
    if let weather = weather {
      let info = DaysInfo(model: weather)
      view.presentWeatherByDays(info, type: .twoWeeks)
    } else {
      view.presentError()
    }
  }

}
