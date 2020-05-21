//
//  AppCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

protocol Coordinator: class {

  func start()
  func dismiss()

}

extension Coordinator {

  func dismiss() { }

}

class AppCoordinator {

  private let container: Container
  private var rootController: UIViewController!
  private let window: UIWindow
  private var childCoordinators = [Coordinator]()

  init(window: UIWindow) {
    self.window = window
    self.container = Container() { RootAssembly().assemble(container: $0) }
  }

  func start() {
    window.rootViewController = UIViewController()
    window.makeKeyAndVisible()
    rootController = window.rootViewController
    presentLaunchFlow()
  }

}

extension AppCoordinator: LaunchScreenInterface {

  func weatherDidLoad(errorWasOccurred: Bool) {
    removeLaunchFlow()
    presentWeatherFlow(errorWasOccurred: errorWasOccurred)
  }
  
}

extension AppCoordinator {

  private func presentLaunchFlow() {
    let launchCoordinator = LaunchCoordinator(rootController: rootController, parentContainer: container)
    childCoordinators.append(launchCoordinator)
    launchCoordinator.delegate = self
    launchCoordinator.start()
  }

  private func presentWeatherFlow(errorWasOccurred: Bool) {
    let weatherCoordinator = WeatherCoordinator(rootController: rootController, errorWasOccurred: errorWasOccurred, parentContainter: container)
    childCoordinators.append(weatherCoordinator)
    weatherCoordinator.start()
  }

  private func removeLaunchFlow() {
    guard let launch = childCoordinators.first(where: { $0 is LaunchCoordinator }) else { return }
    launch.dismiss()
    childCoordinators.removeAll { $0 is LaunchCoordinator }
  }

}
