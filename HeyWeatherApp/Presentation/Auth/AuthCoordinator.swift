//
//  AuthCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Swinject

class AuthCoordinator: Coordinator {

  weak var delegate: AuthNavigatable?

  private let rootController: UIViewController
  private var container: Container
  private var authController: AuthController!
  private var childCoordinators = [Coordinator]()

  init(rootController: UIViewController, parentContainter: Container) {
    self.rootController = rootController
    self.container = Container(parent: parentContainter) { AuthAssembly().assemble(container: $0) }
  }

  func start() {
    authController = container.autoresolve()
    authController.delegate = delegate
    authController.modalPresentationStyle = .fullScreen
    rootController.present(authController, animated: false, completion: nil)
  }

  func dismiss() {
    authController.dismiss(animated: false, completion: nil)
  }

}
