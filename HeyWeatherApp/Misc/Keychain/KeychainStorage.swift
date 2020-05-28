//
//  KeychainStorage.swift
//  Core
//

import KeychainAccess

final class KeychainStorage: KeyValueStorage {
    
    private let storage = Keychain(service: Bundle.main.bundleIdentifier!)
    
    func set(_ value: Any?, forKey key: String) {
        switch value {
        case let value as Data:
            storage[data: key] = value
            
        case let value as String:
            storage[key] = value
            
        default:
            storage[key] = nil
        }
    }
    
    func object(forKey key: String) -> Any? {
        return storage[key] ?? storage[data: key]
    }
    
}
