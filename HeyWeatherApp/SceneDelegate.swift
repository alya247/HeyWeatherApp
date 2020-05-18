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
  var coordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = UIViewController()
    window?.makeKeyAndVisible()
    setupCoordinator(with: window!.rootViewController!)
  }

  private func setupCoordinator(with rootViewController: UIViewController) {
    coordinator = AppCoordinator(rootController: rootViewController)
    coordinator?.start()
  }

}

