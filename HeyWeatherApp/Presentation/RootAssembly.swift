//
//  RootAssembly.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 19.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Swinject

class RootAssembly: Assembly {

  init() {}

  func assemble(container: Container) {
    container.register(WeatherManager.self) { _ in
      let weatherManager = WeatherManager()
      weatherManager.setupLoader()
      return weatherManager
    }.inObjectScope(.container)
  }

}
