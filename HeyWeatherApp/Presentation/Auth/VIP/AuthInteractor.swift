//
//  AuthInteractor.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Core

protocol AuthInteractorInterface: class {

  func signIn(email: String?, password: String?)

}

class AuthInteractor {

  private let presenter: AuthPresenterInterface
  private let userSessionController: UserSessionController

  init(presenter: AuthPresenterInterface, userSessionController: UserSessionController) {
    self.presenter = presenter
    self.userSessionController = userSessionController
  }

}

extension AuthInteractor: AuthInteractorInterface {

  func signIn(email: String?, password: String?) {
    guard let userSessionInfo = presenter.createUserSessionInfo(email: email, password: password) else { return }
    
    userSessionController.openSession(userSessionInfo: userSessionInfo)
    presenter.signInDidCompleted(with: userSessionController.userSession.state)
  }

}
