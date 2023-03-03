//
//  Double+Extension.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 02/03/2023.
//

import Foundation

extension Double {
    
    func getPriceString() -> String {
        let value = String(format: "%g", self)
        return "\(value)€" // TODO: currency
    }
}
