//
//  AppCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject
import Core

protocol Coordinator: class {

  func start()
  func dismiss()

}

extension Coordinator {
  func dismiss() { }
}

protocol AppNavigatable: class {
  func logOut()
}

class AppCoordinator {

  private let container: Container
  private let userSessionController: UserSessionController
  private var rootController: UIViewController!
  private let window: UIWindow
  private var childCoordinators = [Coordinator]()
  private var isUserSignedIn: Bool {
    let isSessionOpened = userSessionController.userSession.state == .opened
    return isSessionOpened ? isSessionOpened : userSessionController.restorePreviousSession()
  }

  init(window: UIWindow) {
    self.window = window
    self.container = Container { RootAssembly().assemble(container: $0) }
    self.userSessionController = container.autoresolve()
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

    if isUserSignedIn {
      presentWeatherFlow(errorWasOccurred: errorWasOccurred)
    } else {
      presentAuthFlow()
    }
  }
  
}

extension AppCoordinator: AuthNavigatable {

  func signIn() {
    removeAuthFlow()
    presentWeatherFlow(errorWasOccurred: false)
  }

}

extension AppCoordinator: AppNavigatable {

  func logOut() {
    removeWeatherFlow()
    presentAuthFlow()
  }

}

extension AppCoordinator {

  // MARK: - Launch

  private func presentLaunchFlow() {
    let launchCoordinator = LaunchCoordinator(rootController: rootController, parentContainer: container)
    childCoordinators.append(launchCoordinator)
    launchCoordinator.delegate = self
    launchCoordinator.start()
  }

  private func removeLaunchFlow() {
    guard let launch = childCoordinators.first(where: { $0 is LaunchCoordinator }) else { return }
    launch.dismiss()
    childCoordinators.removeAll { $0 is LaunchCoordinator }
  }

  // MARK: - Weather

  private func presentWeatherFlow(errorWasOccurred: Bool) {
    let weatherCoordinator = WeatherCoordinator(rootController: rootController,
                                                errorWasOccurred: errorWasOccurred,
                                                parentContainter: container)
    weatherCoordinator.delegate = self
    childCoordinators.append(weatherCoordinator)
    weatherCoordinator.start()
  }

  private func removeWeatherFlow() {
    guard let weather = childCoordinators.first(where: { $0 is WeatherCoordinator }) else { return }
    weather.dismiss()
    childCoordinators.removeAll { $0 is WeatherCoordinator }
  }

  // MARK: - Auth

  private func presentAuthFlow() {
    let authCoordinator = AuthCoordinator(rootController: rootController, parentContainter: container)
    authCoordinator.delegate = self
    childCoordinators.append(authCoordinator)
    authCoordinator.start()
  }

  private func removeAuthFlow() {
    guard let auth = childCoordinators.first(where: { $0 is AuthCoordinator }) else { return }
    auth.dismiss()
    childCoordinators.removeAll { $0 is AuthCoordinator }
  }

}
