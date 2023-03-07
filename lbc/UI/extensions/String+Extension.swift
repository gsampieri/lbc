//
//  String+Extension.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 03/03/2023.
//

import Foundation

extension String {
    var localize: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
