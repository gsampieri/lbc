//
//  CacheManager.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 06/03/2023.
//

import Foundation

class CacheManager<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let entryLifetime: TimeInterval
    
    init(entryLifetime: TimeInterval = 5 * 60) { // 5 min.
        self.entryLifetime = entryLifetime
    }

    func insert(_ value: Value, forKey key: Key) {
        let entry = Entry(value: value, expirationDate: Date().addingTimeInterval(entryLifetime))
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }

    func value(forKey key: Key) -> Value? {
        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
            return nil
        }
        guard entry.isValid else {
            wrapped.removeObject(forKey: WrappedKey(key))
            return nil
        }
        return entry.value
    }

    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }

    private class WrappedKey: NSObject {
        let key: Key
        init(_ key: Key) {
            self.key = key
        }
        override var hash: Int {
            return key.hashValue
        }
        override func isEqual(_ object: Any?) -> Bool {
            guard let wrappedKey = object as? WrappedKey else {
                return false
            }
            return wrappedKey.key == key
        }
    }

    private class Entry {
        let value: Value
        let expirationDate: Date
        var isValid: Bool {
            return Date() < expirationDate
        }
        init(value: Value, expirationDate: Date) {
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}
