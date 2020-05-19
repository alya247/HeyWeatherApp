//
//  LaunchAssembly.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 19.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class LaunchAssembly: Assembly {

  init() {}

  func assemble(container: Container) {
    container.register(LaunchScreenController.self) { resolver in
      let controller = UIStoryboard(name: "Launch", bundle: nil).instantiateViewController(identifier: "LaunchScreenController") as! LaunchScreenController
      controller.weatherManager = resolver.autoresolve()
      return controller
    }.inObjectScope(.transient)
  }

}
