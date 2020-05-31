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
    container.register(WeatherController.self) { (resolver, node: NavigationNode) in
      let controller = StoryboardScene.Weather.weatherController.instantiate()
      let presenter: WeatherPresenterInterface = resolver.autoresolve()
      let interactor: WeatherInteractorInterface = resolver.autoresolve(argument: node)
      presenter.view = controller
      controller.interactor = interactor
      return controller
    }.inObjectScope(.container)

    container.register(WeatherPresenterInterface.self) { _ in
      WeatherPresenter()
    }.inObjectScope(.container)

    container.register(WeatherInteractorInterface.self) { (resolver, node: NavigationNode) in
      WeatherInteractor(parentNode: node, presenter: resolver.autoresolve(),
                        weatherManager: resolver.autoresolve(),
                        errorWasOccurred: false,
                        userSessionController: resolver.autoresolve())
    }.inObjectScope(.container)
  }

}
