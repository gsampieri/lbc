//
//  Constants.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import Foundation

class Constant: NSObject {
    struct api {
        static let baseUrl = Bundle.getParamString(key: "API_BASE_URL")
    }
}
