//
//  LaunchCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class LaunchCoordinator: NavigationNode, Coordinator {

  private let container: Container

  init(parentNode: NavigationNode, parentContainer: Container) {
    self.container = Container(parent: parentContainer) { LaunchAssembly().assemble(container: $0) }
    super.init(parent: parentNode)

    setupHandlers()
  }

  func createFlow() -> UIViewController {
    let node: NavigationNode = self
    let controller: LaunchScreenController = container.autoresolve(argument: node)
    controller.modalPresentationStyle = .fullScreen
    return controller
  }

  private func setupHandlers() {
    addHandler { [weak self] (event: LaunchEvent) in
      switch event {
      case .didLoad:
        self?.raise(event: LaunchFlowEvent.didLoad)
      }
    }
  }

}
