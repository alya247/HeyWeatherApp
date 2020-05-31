//
//  LaunchScreenInteractor.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 31.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

enum LaunchEvent: NavigationEvent {
  case didLoad
}

protocol LaunchScreenInteractorInterface: class {
  func presentHome()
}

class LaunchScreenInteractor: NavigationNode {

  init(parentNode: NavigationNode) {
    super.init(parent: parentNode)
  }

}

extension LaunchScreenInteractor: LaunchScreenInteractorInterface {

  func presentHome() {
    raise(event: LaunchEvent.didLoad)
  }
  
}
