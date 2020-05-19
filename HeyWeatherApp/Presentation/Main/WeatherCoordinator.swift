//
//  '.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class WeatherCoordinator: CommonCoordinator {

  private let rootController: UIViewController
  private let errorWasOccurred: Bool
  private let container: Container
  private var weatherController: WeatherController!

  init(rootController: UIViewController, errorWasOccurred: Bool, parentContainter: Container) {
    self.rootController = rootController
    self.errorWasOccurred = errorWasOccurred
    self.container = Container(parent: parentContainter) { MainAssembly().assemble(container: $0) }
  }

  func start() {
    weatherController = container.autoresolve()
    weatherController.modalPresentationStyle = .fullScreen
    rootController.present(weatherController, animated: false, completion: nil)
  }

}
