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

typealias CategoriesCompletion = ([Category]?, Error?) -> Void
typealias AdvertisementsCompletion = ([Advertisement]?, Error?) -> Void

class RestManager {
    fileprivate static let shared = RestManager()

    func getAdvertisements(completionHandler: @escaping AdvertisementsCompletion) {
        guard let url = URL(string: "\(Constant.api.baseUrl)/listing.json") else {
            completionHandler(nil, nil)
            return
        }
            URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                   let data = data {
                    do {
                        let results = try JSONDecoder().decode([AdvertisementDTO].self, from: data)
                        if httpResponse.statusCode == 200 {
                            completionHandler(results.map( {$0.toEntity()} ), nil)
                            return
                        }
                    } catch let error {
                        completionHandler(nil, error)
                    }
                }
            }
            .resume()
    }
    
    func getCategories(completionHandler: @escaping CategoriesCompletion) {
        guard let url = URL(string: "\(Constant.api.baseUrl)/categories.json") else {
            completionHandler(nil, nil)
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            if let httpResponse = response as? HTTPURLResponse,
               let data = data {
                do {
                    let results = try JSONDecoder().decode([CategoryDTO].self, from: data)
                    if httpResponse.statusCode == 200 {
                        let categories = results.map( {$0.toEntity()} )
                        LbcUserDefaults.categories = categories
                        completionHandler(categories, nil)
                        return
                    }
                } catch let error {
                    completionHandler(nil, error)
                }
            }
        }
        .resume()
    }
    
    func getAdvertisementsCategories(completionHandler: @escaping AdvertisementsCompletion) {
        getCategories { _, error in
            if let error = error {
                completionHandler(nil, error)
                return
            }
            self.getAdvertisements(completionHandler: completionHandler)
        }
    }
}
