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
  func userDidLogOut()
}

class WeatherCoordinator: Coordinator {

  weak var delegate: AppNavigatable?

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

    let navigationController = UINavigationController(rootViewController: weatherController)
    navigationController.modalPresentationStyle = .fullScreen
    rootController.present(navigationController, animated: false, completion: nil)
  }

  func dismiss() {
    weatherController.dismiss(animated: false, completion: nil)
  }

}

extension WeatherCoordinator: WeatherNavigatable {

  func presentMap() {
    let coordinator = MapCoordinator(rootController: weatherController.navigationController!, parentContainter: container)
    childCoordinators.append(coordinator)
    coordinator.start()
  }

  func userDidLogOut() {
    delegate?.logOut()
  }

}
