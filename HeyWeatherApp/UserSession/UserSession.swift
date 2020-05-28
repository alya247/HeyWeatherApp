//
//  UserSession.swift
//  Core
//

import Foundation
import YALAPIClient

enum UserSessionError: Error {
  case credentialsUpdateFailed
}

struct UserSessionConstants {
  static let sessionStateKey: String = "SessionStateKey"
}

private let notificationCenterIdentifier = "\(Bundle.main.bundleIdentifier!).notificationCenter"

public extension Notification.Name {

  static let userSessionStateDidChange = Notification
    .Name("\(notificationCenterIdentifier).userSessionStateDidChange")
  static let userSessionDidUpdateNetworkCredentials = Notification
    .Name("\(notificationCenterIdentifier).userSessionDidUpdateNetworkCredentials")

}

/// Stores authorized user credentials and current user itself. Responsible for user related settings (per session)
public class UserSession {

  public enum State: Int {

    case initialized, opened, closed

  }

  public var userId: String? {
    return sessionInfo?.id
  }

  private(set) public var state: State = .initialized {
    didSet {
      NotificationCenter.default.post(
        name: .userSessionStateDidChange,
        object: nil,
        userInfo: [UserSessionConstants.sessionStateKey: state]
      )
    }
  }

  /// Callbacks when user session was invalidated, so it should be closed
  public var invalidated: ((Error) -> Void)?

  private let credentialsStorage: KeyValueStorage
  private var sessionInfo: UserSessionInfo?

  init(credentialsStorage: KeyValueStorage = KeychainStorage()) {
    self.credentialsStorage = credentialsStorage
  }

  // MARK: - State

  func open(sessionInfo: UserSessionInfo) {
    assert(state != .opened, "Session can be opened once")

    self.sessionInfo = sessionInfo
    saveUserCredentials()
    state = .opened
  }

  func restore(restorationId: String) -> Bool {
    assert(state != .opened, "Session can be opened once")

    guard let userCredentials = retrieveUserCredentials(for: restorationId) else {
      return false
    }

    sessionInfo = UserSessionInfo(id: restorationId, userCredentials: userCredentials)
    state = .opened
    return true
  }

  func close() {
    assert(state == .opened, "Only opened session can be closed")

    removeUserCredentials()
    sessionInfo = nil
    state = .closed
  }

}

// MARK: - Network Credentials Management

extension UserSession {

  private static func userCredentialsStorageKey(for id: String) -> String {
    return ".userSession.userCredentials.\(id)"
  }

  private func retrieveUserCredentials(for userId: String) -> UserCredentials? {
    let credentialsStorageKey = UserSession.userCredentialsStorageKey(for: userId)
    guard let credentialsString = credentialsStorage.object(forKey: credentialsStorageKey) as? String,
      let credentialsData = credentialsString.data(using: .utf8),
      let credentials = try? JSONDecoder().decode(UserCredentials.self, from: credentialsData) else {
        return nil
    }
    return credentials
  }

  private func saveUserCredentials() {
    guard let userId = userId else { return }

    let data = try! JSONEncoder().encode(sessionInfo?.userCredentials)
    //swiftlint:enable force_try
    let credentialsString = String(data: data, encoding: .utf8)!
    credentialsStorage.set(credentialsString, forKey: UserSession.userCredentialsStorageKey(for: userId))
    credentialsStorage.saveChanges()
  }

  private func removeUserCredentials() {
    guard let userId = userId else { return }
    credentialsStorage.set(nil, forKey: UserSession.userCredentialsStorageKey(for: userId))
    credentialsStorage.saveChanges()
  }

}

// MARK: - Used to send authorized network requests

extension UserSession: AuthorizationCredentialsProvider {

  public var authorizationToken: String {
    return ""
  }

  public var authorizationType: AuthType {
    return .default
  }

}

// MARK: - Used to renew network credentials

extension UserSession: AccessCredentialsProvider {

  public var accessToken: String? {
    get {
      return ""
    }
    set {
      guard let _ = newValue else {
        assertionFailure("need value")
        return
      }
    }
  }

  public var exchangeToken: String? {
    get {
      return ""
    }
    set {
      guard let _ = newValue else {
        assertionFailure("need value")
        return
      }
    }
  }

  public func commitCredentialsUpdate(_ update: (AccessCredentialsProvider) -> Void) {
    update(self)
    saveUserCredentials()
  }

  /// Called in case of not successful update
  public func invalidate() {
    invalidated?(UserSessionError.credentialsUpdateFailed)
  }

}
