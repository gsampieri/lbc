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
    private let cache = CacheManager<String, Data>()
    
    func getAdvertisements(completionHandler: @escaping AdvertisementsCompletion) {
        let cacheKey = "\(Constant.api.baseUrl)/listing.json"
        if let cachedData = cache.value(forKey: cacheKey) {
            if let results = try? JSONDecoder().decode([AdvertisementDTO].self, from: cachedData) {
                completionHandler(results.map( {$0.toEntity()} ), nil)
                return
            }
        }

        guard let url = URL(string: cacheKey) else {
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
                        self.cache.insert(data, forKey: cacheKey)
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
        let cacheKey = "\(Constant.api.baseUrl)/categories.json"
        if let cachedData = cache.value(forKey: cacheKey) {
            if let results = try? JSONDecoder().decode([CategoryDTO].self, from: cachedData) {
                let categories = results.map( {$0.toEntity()} )
                LbcUserDefaults.categories = categories
                completionHandler(categories, nil)
                return
            }
        }

        guard let url = URL(string: cacheKey) else {
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
                        self.cache.insert(data, forKey: cacheKey)
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
