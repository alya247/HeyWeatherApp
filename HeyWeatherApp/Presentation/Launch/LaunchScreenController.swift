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
  func presentHome()
}

class LaunchScreenController: UIViewController {

  var weatherManager: WeatherManager!
  weak var delegate: LaunchScreenInterface?

  override func viewDidLoad() {
    super.viewDidLoad()
    performanceTimer()
  }

  func performanceTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.delegate?.presentHome()
    }
  }

}
