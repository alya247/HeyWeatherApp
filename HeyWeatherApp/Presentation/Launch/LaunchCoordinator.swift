//
//  LaunchCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class LaunchCoordinator: Coordinator {

  weak var delegate: LaunchScreenInterface?
  private let rootController: UIViewController
  private let container: Container
  private var launchController: LaunchScreenController!

  init(rootController: UIViewController, parentContainer: Container) {
    self.rootController = rootController
    self.container = Container(parent: parentContainer) { LaunchAssembly().assemble(container: $0) }
  }

  func start() {
    launchController = container.autoresolve()
    launchController.delegate = delegate
    launchController.modalPresentationStyle = .fullScreen
    rootController.present(launchController, animated: false, completion: nil)
  }

  func dismiss() {
    launchController.dismiss(animated: false, completion: nil)
  }

}
