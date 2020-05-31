//
//  AuthCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Swinject

enum LoginEvent: NavigationEvent {
    case login
}

class AuthCoordinator: NavigationNode, Coordinator {

  private var container: Container
  private var authController: AuthController!
  private var childCoordinators = [Coordinator]()

  init(parentNode: NavigationNode, parentContainer: Container) {
    self.container = Container(parent: parentContainer) { AuthAssembly().assemble(container: $0) }

    super.init(parent: parentNode)

    setupHandlers()
  }

  func createFlow() -> UIViewController {
    let node: NavigationNode = self
    let controller: AuthController = container.autoresolve(argument: node)
    return controller
  }

  private func setupHandlers() {
    addHandler { [weak self] (event: LoginEvent) in
      self?.handleEvent(event)
    }
  }

  private func handleEvent(_ event: LoginEvent) {
    switch event {
    case .login:
      raise(event: AuthEvent.login)
    }
  }

}
