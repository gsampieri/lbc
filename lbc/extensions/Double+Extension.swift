//
//  Double+Extension.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 02/03/2023.
//

import Foundation

extension Double {
    
    func getPriceString() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = "EUR"
        formatter.currencySymbol = "€"
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.alwaysShowsDecimalSeparator = false
        
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
