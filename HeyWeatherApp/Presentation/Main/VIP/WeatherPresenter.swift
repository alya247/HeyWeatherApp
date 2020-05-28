//
//  WeatherPresenter.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol WeatherPresenterInterface: class {

  var view: WeatherViewInterface! { get set }
  var currentWeather: BehaviorSubject<WeatherInfo?> { get set }
  var periodWeather: BehaviorSubject<(model: DaysInfo?, type: PeriodSelectorType)> { get set }
  func weatherDidLoad()
  func errorWasOccurred()
  func presentCurrentWeather(_ weather: WeatherModel?)
  func presentWeekWeather(_ weather: WeatherDaysModel?)
  func presentTwoWeekWeather(_ weather: WeatherDaysModel?)
  func userDidLogOut()
}

class WeatherPresenter {

  var currentWeather: BehaviorSubject<WeatherInfo?> = BehaviorSubject<WeatherInfo?>(value: nil)
  var periodWeather = BehaviorSubject<(model: DaysInfo?, type: PeriodSelectorType)>(value: (nil, .week))
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
      currentWeather.onNext(info)
    } else {
      view.presentError()
      currentWeather.onNext(nil)
    }
    
  }

  func presentWeekWeather(_ weather: WeatherDaysModel?) {
    if let weather = weather {
      let info = DaysInfo(model: weather)
      periodWeather.onNext((info, .week))
    } else {
      view.presentError()
    }
  }

  func presentTwoWeekWeather(_ weather: WeatherDaysModel?) {
    if let weather = weather {
      let info = DaysInfo(model: weather)
      periodWeather.onNext((info, .twoWeeks))
    } else {
      view.presentError()
    }
  }

  func userDidLogOut() {
    view.userDidLogOut()
  }

}
