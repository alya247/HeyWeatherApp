//
//  '.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

protocol WeatherNavigatable: class {
  func presentMap()
}

class WeatherCoordinator: Coordinator {

  private let rootController: UIViewController
  private let errorWasOccurred: Bool
  private var container: Container
  private var weatherController: WeatherController!
  private var childCoordinators = [Coordinator]()

  init(rootController: UIViewController, errorWasOccurred: Bool, parentContainter: Container) {
    self.rootController = rootController
    self.errorWasOccurred = errorWasOccurred
    self.container = Container(parent: parentContainter) { MainAssembly().assemble(container: $0) }
  }

  func start() {
    weatherController = container.autoresolve()
    weatherController.delegate = self

    let n = UINavigationController(rootViewController: weatherController)
    n.modalPresentationStyle = .fullScreen
    rootController.present(n, animated: false, completion: nil)
  }

}

extension WeatherCoordinator: WeatherNavigatable {

  func presentMap() {
    let coordinator = MapCoordinator(rootController: weatherController.navigationController!, parentContainter: container)
    childCoordinators.append(coordinator)
    coordinator.start()
  }

}
