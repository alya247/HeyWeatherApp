//
//  SelectedLocation.swift
//  Core
//
//  Created by Alya Filon  on 28.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

public struct SelectedLocation: Codable {

  public var latitude: Double
  public var longitude: Double

  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }

}
