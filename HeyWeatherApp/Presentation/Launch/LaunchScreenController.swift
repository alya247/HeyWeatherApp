//
//  LaunchScreenController.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 18.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import Core

protocol LaunchScreenInterface: class {
  func weatherDidLoad(errorWasOccurred: Bool)
}

class LaunchScreenController: UIViewController {

  var weatherManager: WeatherManager!
  weak var delegate: LaunchScreenInterface?

  override func viewDidLoad() {
    super.viewDidLoad()

    loadWeather()
  }

  func loadWeather() {
    weatherManager.loadWeather { [weak self] errorWasOccurred in
      guard let `self` = self else { return }
      self.delegate?.weatherDidLoad(errorWasOccurred: errorWasOccurred)
    }
  }

}
