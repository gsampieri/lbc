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

//typealias CategoryCompletion = ([CategoryDTO]?, Error?) -> Void
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
            
            if response != nil,
               let data = data {
                do {
                    let results = try JSONDecoder().decode([AdvertisementDTO].self, from: data)
                    // TODO: refactor this 
//                    if response. == 200 {
                    var advertisements: [Advertisement] = []
                    for result in results {
                        advertisements.append(result.toEntity())
                    }
                        completionHandler(advertisements, nil)
                        return
//                    }
                } catch let error {
                    completionHandler(nil, error)
                }
            }
        }
        .resume()
    }
}
