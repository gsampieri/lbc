//
//  Bundle+Extension.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import Foundation

extension Bundle {
    static func getParamString(key: String) -> String {
        return main.infoDictionary![key] as! String 
    }
}
