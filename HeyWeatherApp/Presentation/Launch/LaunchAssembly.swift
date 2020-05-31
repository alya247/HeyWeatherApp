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
    container.register(LaunchScreenController.self) { (resolver, node: NavigationNode) in
      let controller = StoryboardScene.Launch.launchScreenController.instantiate()
      let interactor: LaunchScreenInteractorInterface = resolver.autoresolve(argument: node)
      controller.interactor = interactor
      return controller
    }.inObjectScope(.transient)

    container.register(LaunchScreenInteractorInterface.self) { (_, node: NavigationNode) in
      LaunchScreenInteractor(parentNode: node)
    }.inObjectScope(.container)
  }

}
