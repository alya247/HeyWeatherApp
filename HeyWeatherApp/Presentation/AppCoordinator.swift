//
//  AppCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject
//TODO: - внести в протокол методы start и dismiss
protocol CommonCoordinator: class { }

class AppCoordinator {

  private let container: Container
  private let rootController: UIViewController
  private var childCoordinators = [CommonCoordinator]()

  init(rootController: UIViewController) {
    self.rootController = rootController
    self.container = Container() { RootAssembly().assemble(container: $0) }
  }

  func start() {
    setLaunchScreen()
  }

}

extension AppCoordinator: LaunchScreenInterface {

  func weatherDidLoad(errorWasOccurred: Bool) {
    removeLaunchScreen()
    setWeatherController(errorWasOccurred: errorWasOccurred)
  }
  
}

extension AppCoordinator {
  //TODO: - переименовать в presentLaunchFlow. Аналогично для setWeatherController
  private func setLaunchScreen() {
    let launchCoordinator = LaunchCoordinator(rootController: rootController, parentContainer: container)
    childCoordinators.append(launchCoordinator)
    launchCoordinator.delegate = self
    launchCoordinator.start()
  }

  private func setWeatherController(errorWasOccurred: Bool) {
    let weatherCoordinator = WeatherCoordinator(rootController: rootController, errorWasOccurred: errorWasOccurred, parentContainter: container)
    childCoordinators.append(weatherCoordinator)
    weatherCoordinator.start()
  }

  private func removeLaunchScreen() {
    guard let index = childCoordinators.firstIndex(where: { $0 is LaunchCoordinator }), let launch = childCoordinators[index] as? LaunchCoordinator else { return }
    launch.dismiss()
    childCoordinators.remove(at: index)
  }

}
