//
//  MapCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 26.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

protocol MapNavigatable: class {
  func reloadWeatherIfNeeded()
}

protocol MapCoordinatorInterface: class {

}

class MapCoordinator: Coordinator {

  private let rootController: UINavigationController
  private var container: Container
  private var mapController: MapController!

  init(rootController: UINavigationController, parentContainter: Container) {
    self.rootController = rootController
    self.container = Container(parent: parentContainter) { MapAssembly().assemble(container: $0) }
  }

  func start() {
    mapController = container.autoresolve()
    mapController.delegate = self
    rootController.pushViewController(mapController, animated: true)
  }
  
}

extension MapCoordinator: MapNavigatable {

  func reloadWeatherIfNeeded() {
    rootController.popViewController(animated: true)
  }

}
