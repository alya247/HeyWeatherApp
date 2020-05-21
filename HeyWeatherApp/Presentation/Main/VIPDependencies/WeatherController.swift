//
//  ViewController.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol WeatherViewInterface: class {

  func weatherDidLoad()
  func presentError()
}

class WeatherController: UIViewController {

  var interactor: WeatherInteractorInterface!

  @IBOutlet private weak var currentWeatherView: CurrentWeatherView!
  @IBOutlet private weak var periodSelectorView: PeriodSelectorView!
  @IBOutlet private weak var barChartView: BarChartView!

  private let bag = DisposeBag()
  private var daysWeatherView: DaysWeatherView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupDaysWeatherView()

    periodSelectorView.applySelectors([.current, .week, .twoWeeks])
    periodSelectorView.delegate = self
    barChartView.delegate = self
    interactor.getWeather(for: .current)
    setupObservers()
  }

}

// MARK: - WeatherViewInterface

extension WeatherController: WeatherViewInterface {

  func weatherDidLoad() {
    interactor.getWeather(for: .current)
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
    setViews(isCurrent: type == .current)
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

  private func setupObservers() {
    currentWeatherView.bind(to: interactor.currentWeather)
    daysWeatherView.bind(model: interactor.periodWeather)

    interactor.barChartValues.observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] values in
      self?.barChartView.apply(values: values)
    }).disposed(by: bag)
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
