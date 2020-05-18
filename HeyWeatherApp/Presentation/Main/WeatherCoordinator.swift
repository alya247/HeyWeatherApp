//
//  '.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class WeatherCoordinator: CommonCoordinator {

  private let rootController: UIViewController
  private let weatherManager: WeatherManager
  private let errorWasOccurred: Bool
  private var weatherController: WeatherController!

  init(rootController: UIViewController, weatherManager: WeatherManager, errorWasOccurred: Bool) {
    self.rootController = rootController
    self.weatherManager = weatherManager
    self.errorWasOccurred = errorWasOccurred
  }

  func start() {
    weatherController = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(identifier: "WeatherController")
    let presenter = WeatherPresenter()
    let interactor = WeatherInteractor(presenter: presenter,
                                       weatherManager: weatherManager,
                                       errorWasOccurred: errorWasOccurred)
    presenter.view = weatherController
    weatherController.interactor = interactor

    weatherController.modalPresentationStyle = .fullScreen
    rootController.present(weatherController, animated: false, completion: nil)
  }

}
