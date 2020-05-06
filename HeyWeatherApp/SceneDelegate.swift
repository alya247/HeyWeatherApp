//
//  SceneDelegate.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let _ = (scene as? UIWindowScene) else { return }
    setupDependencies()
  }

  private func setupDependencies() {
    if let rootController = window?.rootViewController as? WeatherController {
      let presenter = WeatherPresenter()
      let interactor = WeatherInteractor(presenter: presenter)
      presenter.view = rootController
      rootController.interactor = interactor
    }
  }

}

