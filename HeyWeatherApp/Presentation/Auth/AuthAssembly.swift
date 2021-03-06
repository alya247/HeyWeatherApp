//
//  AuthAssembly.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Swinject
import Core

class AuthAssembly: Assembly {

  init() {}

  func assemble(container: Container) {
    container.register(AuthController.self) { (resolver, node: NavigationNode) in
      let controller = StoryboardScene.Auth.authController.instantiate()
      let presenter: AuthPresenterInterface = resolver.autoresolve()
      let interactor: AuthInteractorInterface = resolver.autoresolve(argument: node)
      presenter.view = controller
      controller.interactor = interactor

      return controller
    }.inObjectScope(.transient)

    container.register(AuthPresenterInterface.self) { _ in
      AuthPresenter()
    }.inObjectScope(.transient)

    container.register(AuthInteractorInterface.self) { (resolver, node: NavigationNode) in
      AuthInteractor(parentNode: node,
                     presenter: resolver.autoresolve(),
                     userSessionController: resolver.autoresolve())
    }.inObjectScope(.transient)

  }

}
