//
//  MainAssembly.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 19.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class MainAssembly: Assembly {

  init() {}

  func assemble(container: Container) {
    container.register(WeatherController.self) { resolver in
      let controller = StoryboardScene.Weather.weatherController.instantiate()
      let presenter: WeatherPresenterInterface = resolver.autoresolve()
      let interactor: WeatherInteractorInterface = resolver.autoresolve()
      presenter.view = controller
      controller.interactor = interactor
      return controller
    }.inObjectScope(.transient)

    container.register(WeatherPresenterInterface.self) { _ in
      return WeatherPresenter()
    }.inObjectScope(.container)

    container.register(WeatherInteractorInterface.self) { resolver in
      return WeatherInteractor(presenter: resolver.autoresolve(),
                               weatherManager: resolver.autoresolve(),
                               errorWasOccurred: false)
    }.inObjectScope(.container)
  }

}
