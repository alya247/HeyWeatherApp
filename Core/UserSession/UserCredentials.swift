//
//  UserCredentials.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

public struct UserCredentials: Codable {

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

}
