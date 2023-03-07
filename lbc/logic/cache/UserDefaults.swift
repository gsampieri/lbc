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
            if let decoded  = UserDefaults.standard.object(forKey: key) as? Data {
                return try? JSONDecoder().decode(T.self, from: decoded)
            }
            return nil
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
