//
//  AdvertisementDTO.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import Foundation

struct AdvertisementDTO: Codable {
    let id: Double?
    let category_id: Double?
    let title: String?
    let description: String?
    let price: Double?
    let images_url: AdvertisementImagesDTO?
    let creationDate: String?
    let isUrgent: Bool?
    let siret: String?
    
    func toEntity() -> Advertisement {
        var smallImageUrl: URL?
        var thumbImageUrl: URL?
        if let smallImage = images_url?.small,
           let _smallImageUrl = URL(string: smallImage) {
            smallImageUrl = _smallImageUrl
        }
        if let thumbImage = images_url?.small,
           let _thumbImageUrl = URL(string: thumbImage) {
            thumbImageUrl = _thumbImageUrl
        }
        if let categorie = LbcUserDefaults.categories?.first(where: { $0.id == category_id ?? 0 }) {
            print(categorie)
        }
        return Advertisement(id: id ?? 0,
                             categoryId: category_id ?? 0,
                             category: LbcUserDefaults.categories?.first(where: { $0.id == category_id ?? 0 }) ?? Category(id: 0, name: ""),
                             title: title ?? "",
                             description: description ?? "",
                             price: price ?? 0,
                             smallImage: smallImageUrl,
                             thumbImage: thumbImageUrl,
                             creationDate: Date(),
                             isUrgent: isUrgent ?? false,
                             siret: siret)
    }
}

struct AdvertisementImagesDTO: Codable {
    let small: String?
    let thumb: String?
}
