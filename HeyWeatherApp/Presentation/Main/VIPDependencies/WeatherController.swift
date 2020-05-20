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

  var interactor: WeatherInteractorInterface!

  @IBOutlet private weak var currentWeatherView: CurrentWeatherView!
  @IBOutlet private weak var periodSelectorView: PeriodSelectorView!
  @IBOutlet private weak var barChartView: BarChartView!

  private var daysWeatherView: DaysWeatherView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupDaysWeatherView()

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

  private func setupDaysWeatherView() {
    daysWeatherView = DaysWeatherView()
    view.addSubview(daysWeatherView)
    daysWeatherView.layout {
      $0.leading.equal(to: view.leadingAnchor)
      $0.trailing.equal(to: view.trailingAnchor)
      $0.top.equal(to: periodSelectorView.bottomAnchor, offsetBy: 20)
      $0.bottom.equal(to: barChartView.topAnchor, offsetBy: 30)
      $0.height.equal(to: 345)
    }
  }

}
