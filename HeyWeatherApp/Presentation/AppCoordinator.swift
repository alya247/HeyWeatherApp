//
//  AppCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

protocol CommonCoordinator: class { }

class AppCoordinator {

  private let rootController: UIViewController
  fileprivate var childCoordinators = [CommonCoordinator]()

  init(rootController: UIViewController) {
    self.rootController = rootController
  }

  func start() {
    setLaunchScreen()
  }

}

extension AppCoordinator: LaunchScreenInterface {

  func weatherDidLoad(with weatherManager: WeatherManager, errorWasOccurred: Bool) {
    removeLaunchScreen()
    setWeatherController(with: weatherManager, errorWasOccurred: errorWasOccurred)
  }
  
}

extension AppCoordinator {

  private func setLaunchScreen() {
    let launchCoordinator = LaunchCoordinator(rootController: rootController)
    childCoordinators.append(launchCoordinator)
    launchCoordinator.delegate = self
    launchCoordinator.start()
  }

  private func setWeatherController(with weatherManager: WeatherManager, errorWasOccurred: Bool) {
    let weatherCoordinator = WeatherCoordinator(rootController: rootController, weatherManager: weatherManager, errorWasOccurred: errorWasOccurred)
    childCoordinators.append(weatherCoordinator)
    weatherCoordinator.start()
  }

  private func removeLaunchScreen() {
    guard let index = childCoordinators.firstIndex(where: { $0 is LaunchCoordinator }), let launch = childCoordinators[index] as? LaunchCoordinator else { return }
    launch.dismiss()
    childCoordinators.remove(at: index)
  }

}
