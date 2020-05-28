//
//  AuthController.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 27.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol AuthNavigatable: class {
  func signIn()
}

protocol AuthViewInterface: class {

  func signInSuccess()
  func signInDidFail()
}

class AuthController: UIViewController {

  @IBOutlet private weak var emailTextField: UITextField!
  @IBOutlet private weak var passwordTextField: UITextField!

  var interactor: AuthInteractorInterface!
  weak var delegate: AuthNavigatable?
  private let bag = DisposeBag()

  private var email: String?
  private var password: String?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupObservers()
  }
  
}

extension AuthController: AuthViewInterface {

  func signInSuccess() {
    delegate?.signIn()
  }

  func signInDidFail() {
    let alert = UIAlertController(title: "Error;(", message: "Sign In did fail", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }

}

extension AuthController {

  @IBAction private func signIn(_ sender: UIButton) {
    interactor.signIn(email: email, password: password)
  }

  private func setupObservers() {
    emailTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] in
      self?.view.endEditing(true)
    }).disposed(by: bag)
    passwordTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] in
      self?.view.endEditing(true)
    }).disposed(by: bag)

    emailTextField.rx.text.subscribe(onNext: { [weak self] text in
      self?.email = text
    }).disposed(by: bag)
    passwordTextField.rx.text.subscribe(onNext: { [weak self] text in
      self?.password = text
    }).disposed(by: bag)
  }

}
