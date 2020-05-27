//
//  MapAssembly.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 26.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class MapAssembly: Assembly {

  init() {}

  func assemble(container: Container) {
    container.register(MapController.self) { resolver in
      let controller = StoryboardScene.Map.mapController.instantiate()
      controller.locationManager = resolver.autoresolve()
      return controller
    }.inObjectScope(.transient)
  }

}
