//
//  '.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class WeatherCoordinator: NavigationNode, Coordinator {

  private var container: Container
  private var weatherController: WeatherController!
  private var childCoordinators = [Coordinator]()

  init(parentNode: NavigationNode, parentContainer: Container) {
    self.container = Container(parent: parentContainer) { MainAssembly().assemble(container: $0) }
    super.init(parent: parentNode)

    setupHandlers()
  }

  func createFlow() -> UIViewController {
    let node: NavigationNode = self
    weatherController = container.autoresolve(argument: node)
    return UINavigationController(rootViewController: weatherController)
  }

  private func setupHandlers() {
    addHandler { [weak self] (event: WeatherEvent) in
      switch event {
      case .logOut:
        self?.raise(event: MainEvent.logOut)
      case .search:
        self?.presentMap()
      }
    }
  }

  private func presentMap() {
    let coordinator = MapCoordinator(rootController: weatherController.navigationController!, parentContainter: container)
    childCoordinators.append(coordinator)
    coordinator.start()
  }

}
