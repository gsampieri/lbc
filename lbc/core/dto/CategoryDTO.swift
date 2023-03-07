//
//  CategoryDTO.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 03/03/2023.
//

import Foundation

struct CategoryDTO: Codable {
    let id: Double
    let name: String?
    
    func toEntity() -> Category {
        return Category(id: id,
                        name: name ?? "")
    }
}
