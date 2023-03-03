//
//  UserDefaults.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 03/03/2023.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    let key: String

    init(_ key: String) {
        self.key = key
    }

    var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T
        }
        set {
            let encodedData = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
}

struct LbcUserDefaults {
    @UserDefaultWrapper("categories")
    static var categories: [Category]?
}
