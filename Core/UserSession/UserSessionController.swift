//
//  UserSessionController.swift
//  Core
//

import Foundation

private let userSessionIdentifierKey = "\(Bundle.main.bundleIdentifier!).userSession.identifier"

/// Responsible for managing UserSession object: opening, closing, restoration.
public class UserSessionController {
    
    /// Calls when session has been invalidated / unexpectedly closed. May be called on background thread
    public var sessionInvalidated: ((Error) -> Void)?
    public var sessionWillInvalidate: (() -> Void)?
    
    public private(set) var userSession: UserSession
    
    private let storage: KeyValueStorage
    
    private var userSessionIdentifier: String? {
        get {
            return storage.object(forKey: userSessionIdentifierKey) as? String
        }
        set {
            storage.set(newValue, forKey: userSessionIdentifierKey)
            storage.saveChanges()
        }
    }
    
    // MARK: - Init
    
    public init(storage: KeyValueStorage = UserDefaults.standard) {
        self.storage = storage
        
        userSession = UserSession()
        userSession.invalidated = { [unowned self] error in
            self.sessionWillInvalidate?()
            self.invalidate(error)
        }
    }
    
    // MARK: Session management
    
    public func openSession(userSessionInfo: UserSessionInfo) {
        userSessionIdentifier = userSessionInfo.id
        userSession.open(sessionInfo: userSessionInfo)
    }
    
    public func closeSession() {
        userSession.close()
        userSessionIdentifier = nil
    }
    
    private func invalidate(_ error: Error) {
        closeSession()
        sessionInvalidated?(error)
    }
    
    // MARK: - Session Restoration
    
    @discardableResult
    public func restorePreviousSession() -> Bool {
        guard
            let identifier = userSessionIdentifier, !identifier.isEmpty
            else { return false }
        
        return userSession.restore(restorationId: identifier)
    }
    
}
