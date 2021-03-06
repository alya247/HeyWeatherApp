//
//  KeyValueStorage.swift
//  Core
//

import Foundation

public protocol KeyValueStorage {
    
    /**
     Immediately stores a value (or removes the value if nil is passed as the value) for the provided key
     */
    func set(_ value: Any?, forKey key: String)
    func object(forKey key: String) -> Any?
    func saveChanges()
    
}

extension KeyValueStorage {
    
    public func saveChanges() {}
    
}

extension UserDefaults: KeyValueStorage {}
