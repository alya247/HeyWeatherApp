//
//  '.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

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
    let container = Container()
    weatherController = UIStoryboard(name: "Weather", bundle: nil).instantiateViewController(identifier: "WeatherController")

    container.register(WeatherPresenterInterface.self) { _ in
      let presenter = WeatherPresenter()
      presenter.view = self.weatherController
      return presenter
    }

    container.register(WeatherInteractorInterface.self, factory: { (resolver: Resolver) in
      return WeatherInteractor(presenter: resolver.resolve(WeatherPresenterInterface.self)!, weatherManager: self.weatherManager, errorWasOccurred: self.errorWasOccurred)
    })

    weatherController.interactor = container.resolve(WeatherInteractorInterface.self)!
    weatherController.modalPresentationStyle = .fullScreen
    rootController.present(weatherController, animated: false, completion: nil)
  }

}
