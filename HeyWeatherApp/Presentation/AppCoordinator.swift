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
  func start() { }
  func dismiss() { }
}

enum LaunchFlowEvent: NavigationEvent {
  case didLoad
}

enum MainEvent: NavigationEvent {
  case logOut
}

enum AuthEvent: NavigationEvent {
  case login
}

class AppCoordinator: NavigationNode {

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

    super.init(parent: nil)

    setupHandlers()
  }

  func start() {
    window.rootViewController = UIViewController()
    window.makeKeyAndVisible()
    rootController = window.rootViewController
    presentLaunchFlow()
  }

}

extension AppCoordinator {

  private func setupHandlers() {
    addHandler { [weak self] (event: LaunchFlowEvent) in
      self?.handleLaunch(event)
    }
    addHandler { [weak self] (event: AuthEvent) in
      self?.handleAuth(event)
    }
    addHandler { [weak self] (event: MainEvent) in
      self?.handleMain(event)
    }
  }

  private func handleLaunch(_ event: LaunchFlowEvent) {
    switch event {
    case .didLoad:
      presentHome()
    }
  }

  private func handleAuth(_ event: AuthEvent) {
    switch event {
    case .login:
      presentWeatherFlow()
    }
  }

  private func handleMain(_ event: MainEvent) {
    switch event {
    case .logOut:
      presentAuthFlow()
    }
  }

  private func presentHome() {
    if isUserSignedIn {
      presentWeatherFlow()
    } else {
      presentAuthFlow()
    }
  }

  // MARK: - Launch

  private func presentLaunchFlow() {
    let node: NavigationNode = self
    let coordinator: LaunchCoordinator = container.autoresolve(argument: node)
    setWindowRootViewController(with: coordinator.createFlow())
  }

  private func removeLaunchFlow() {
    childCoordinators.removeAll { $0 is LaunchCoordinator }
  }

  // MARK: - Weather

  private func presentWeatherFlow() {
    let node: NavigationNode = self
    let coordinator: WeatherCoordinator = container.autoresolve(argument: node)
    setWindowRootViewController(with: coordinator.createFlow())
  }

  // MARK: - Auth

  private func presentAuthFlow() {
    let node: NavigationNode = self
    let coordinator: AuthCoordinator = container.autoresolve(argument: node)
    setWindowRootViewController(with: coordinator.createFlow())
  }

  private func setWindowRootViewController(with viewController: UIViewController) {
      window.rootViewController = viewController
      window.makeKeyAndVisible()
  }

}
