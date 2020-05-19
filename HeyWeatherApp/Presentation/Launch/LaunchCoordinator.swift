//
//  LaunchCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Swinject

class LaunchCoordinator: CommonCoordinator {

  weak var delegate: LaunchScreenInterface?
  private let rootController: UIViewController
  private var launchController: LaunchScreenController!

  init(rootController: UIViewController) {
    self.rootController = rootController
  }

  func start() {
    let container = Container()
    container.register(WeatherManager.self) { _ in
      let weatherManager = WeatherManager()
      weatherManager.setupLoader()
      return weatherManager
    }

    launchController = UIStoryboard(name: "Launch", bundle: nil).instantiateViewController(identifier: "LaunchScreenController")
    launchController.weatherManager = container.resolve(WeatherManager.self)!
    launchController.delegate = delegate
    launchController.modalPresentationStyle = .fullScreen
    rootController.present(launchController, animated: false, completion: nil)
  }

  func dismiss() {
    launchController.dismiss(animated: false, completion: nil)
  }

}
