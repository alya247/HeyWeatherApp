//
//  LaunchCoordinator.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class LaunchCoordinator: CommonCoordinator {

  private let rootController: UIViewController
  weak var delegate: LaunchScreenInterface?
  private var launchController: LaunchScreenController!

  init(rootController: UIViewController) {
    self.rootController = rootController
  }

  func start() {
    launchController = UIStoryboard(name: "Launch", bundle: nil).instantiateViewController(identifier: "LaunchScreenController")
    launchController.weatherManager = setupWeatherManager()
    launchController.delegate = delegate
    launchController.modalPresentationStyle = .fullScreen
    rootController.present(launchController, animated: false, completion: nil)
  }

  func dismiss() {
    launchController.dismiss(animated: false, completion: nil)
  }

  private func setupWeatherManager() -> WeatherManager {
    let weatherManager = WeatherManager()
    weatherManager.setupLoader()
    return weatherManager
  }
}
