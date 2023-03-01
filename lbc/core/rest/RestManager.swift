//
//  RestManager.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import Foundation

protocol RestManagerDependant {}

extension RestManagerDependant {
    var restManager: RestManager {
        return RestManager.shared
    }
}

class RestManager {
    fileprivate static let shared = RestManager()

}
