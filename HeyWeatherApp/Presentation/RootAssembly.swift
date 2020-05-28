//
//  RootAssembly.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 19.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Swinject
import Core

class RootAssembly: Assembly {

  init() {}

  func assemble(container: Container) {
    container.register(WeatherLoader.self) { resolver in
      WeatherLoader(weatherManager: resolver.autoresolve())
    }.inObjectScope(.container)

    container.register(WeatherManager.self) { _ in WeatherManager() }
      .initCompleted { resolver, manager in
      manager.weatherLoader = resolver.autoresolve()
      manager.locationManager = resolver.autoresolve()
    }.inObjectScope(.container)

    container.register(LocationManager.self) { _ in
      LocationManager()
    }.inObjectScope(.container)

    container.register(UserSessionController.self) { _ in
      UserSessionController()
    }.inObjectScope(.container)

  }

}
