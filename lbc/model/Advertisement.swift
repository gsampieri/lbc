//
//  Advertisement.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import Foundation

struct Advertisement: Codable {
    let id: Double
    let categoryId: Int
    let title: String
    let description: String
    let price: Double
    let smallImage: URL?
    let thumbImage: URL?
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?
}
