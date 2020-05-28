//
//  UserSessionInfo.swift
//  Core
//

import Foundation

public struct UserSessionInfo {
    
    public var id: String = "666"
    public var userCredentials: UserCredentials

  public init(id: String = "666", userCredentials: UserCredentials) {
    self.id = id
    self.userCredentials = userCredentials
  }
            
}
