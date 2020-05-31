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

class AuthInteractor: NavigationNode {

  private let presenter: AuthPresenterInterface
  private let userSessionController: UserSessionController

  init(parentNode: NavigationNode, presenter: AuthPresenterInterface, userSessionController: UserSessionController) {
    self.presenter = presenter
    self.userSessionController = userSessionController

    super.init(parent: parentNode)
  }

}

extension AuthInteractor: AuthInteractorInterface {

  func signIn(email: String?, password: String?) {
    guard let userSessionInfo = presenter.createUserSessionInfo(email: email, password: password) else { return }
    userSessionController.openSession(userSessionInfo: userSessionInfo)

    guard presenter.isSignInSuccess(with: userSessionController.userSession.state) else { return  }
    raise(event: LoginEvent.login)
  }

}
