//
//  ViewController.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

protocol WeatherViewInterface: class {

  func weatherDidLoad()
  func presentCurrentWeather(_ weather: WeatherInfo)
  func presentWeatherByDays(_ weather: DaysInfo, type: PeriodSelectorType)
  func presentError()
}

class WeatherController: UIViewController {

  @IBOutlet private var currentWeatherView: CurrentWeatherView!
  @IBOutlet private var daysWeatherView: DaysWeatherView!
  @IBOutlet private var periodSelectorView: PeriodSelectorView!
  @IBOutlet private var barChartView: BarChartView!

  var interactor: WeatherInteractorInterface!

  override func viewDidLoad() {
    super.viewDidLoad()

    periodSelectorView.applySelectors([.current, .week, .twoWeeks])
    periodSelectorView.delegate = self
    barChartView.delegate = self
    interactor.getWeather(for: .current)
  }

}

// MARK: - WeatherViewInterface

extension WeatherController: WeatherViewInterface {

  func weatherDidLoad() {
    interactor.getWeather(for: .current)
  }

  func presentCurrentWeather(_ weather: WeatherInfo) {
    setViews(isCurrent: true)
    currentWeatherView.apply(weather)
  }

  func presentWeatherByDays(_ weather: DaysInfo, type: PeriodSelectorType) {
    setViews(isCurrent: false)
    daysWeatherView.apply(model: weather, periodType: type)

    let values = interactor.getChartValues(for: type)
    barChartView.apply(values: values)
  }

  func presentError() {
    let alert = UIAlertController(title: "Error;(", message: "No internet connection. Old data might be showed", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
}

// MARK: - SelectorDelegate

extension WeatherController: SelectorDelegate {

  func didSelectPeriod(with type: PeriodSelectorType) {
    interactor.getWeather(for: type)
  }

}

// MARK: - BarChartSelectionInterface

extension WeatherController: BarChartSelectionInterface {

  func didSelectBar(for index: Int) {
    daysWeatherView.setSelectedDay(for: index)
  }

}

// MARK: - Private Methods

extension WeatherController {

  private func setViews(isCurrent: Bool) {
    currentWeatherView.isHidden = !isCurrent
    daysWeatherView.isHidden = isCurrent
    barChartView.isHidden = isCurrent
  }

}
