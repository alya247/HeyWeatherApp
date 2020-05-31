//
//  LaunchScreenController.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Core

class LaunchScreenController: UIViewController {

  var weatherManager: WeatherManager!
  var interactor: LaunchScreenInteractorInterface!

  override func viewDidLoad() {
    super.viewDidLoad()
    performanceTimer()
  }

  func performanceTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.interactor.presentHome()
    }
  }

}
