//
//  UIImageView+Extension.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 02/03/2023.
//

import UIKit

extension UIImageView {
    
    private static let imageCache = CacheManager<URL, UIImage>()
    
    func getImage(from url: URL) {
        
        if let cachedImage = UIImageView.imageCache.value(forKey: url) {
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                    UIImageView.imageCache.insert(image, forKey: url)
                }
        }.resume()
    }
}
