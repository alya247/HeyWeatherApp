//
//  AuthPresenter.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation

protocol AuthPresenterInterface: class {

  var view: AuthViewInterface! { get set }
  func createUserSessionInfo(email: String?, password: String?) -> UserSessionInfo?
  func signInDidCompleted(with state: UserSession.State)
  
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

  func signInDidCompleted(with state: UserSession.State) {
    if state == .opened {
      view.signInSuccess()
    } else {
      view.signInDidFail()
    }
  }
  
}
