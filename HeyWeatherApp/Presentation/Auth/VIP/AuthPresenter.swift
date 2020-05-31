//
//  AuthPresenter.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Core

protocol AuthPresenterInterface: class {

  var view: AuthViewInterface! { get set }
  func createUserSessionInfo(email: String?, password: String?) -> UserSessionInfo?
  func isSignInSuccess(with state: UserSession.State) -> Bool
  
}

class AuthPresenter {

  unowned var view: AuthViewInterface!
  
}

extension AuthPresenter: AuthPresenterInterface {

  func createUserSessionInfo(email: String?, password: String?) -> UserSessionInfo? {
    guard let email = email, let password = password else {
      view.signInDidFail()
      return nil
    }
    return UserSessionInfo(userCredentials: UserCredentials(email: email, password: password))
  }

  func isSignInSuccess(with state: UserSession.State) -> Bool {
    if state == .opened {
      return true
    } else {
      view.signInDidFail()
      return false
    }
  }

}
