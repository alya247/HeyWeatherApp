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
    container.register(LaunchScreenController.self) { _ in
      let controller = StoryboardScene.Launch.launchScreenController.instantiate()
      return controller
    }.inObjectScope(.transient)
  }

}
