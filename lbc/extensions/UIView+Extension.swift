//
//  UIView+Extension.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 02/03/2023.
//

import Foundation
import UIKit

extension UIView {
    
    func anchor(topAnchor: NSLayoutYAxisAnchor? = nil, leftAnchor: NSLayoutXAxisAnchor? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil, rightAnchor: NSLayoutXAxisAnchor? = nil, widthAnchor: NSLayoutDimension? = nil, paddingTop: CGFloat = 0, paddingLeft: CGFloat = 0, paddingBottom: CGFloat = 0, paddingRight: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0, enableInsets: Bool = false) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        let insets = self.safeAreaInsets
        topInset = insets.top
        bottomInset = insets.bottom
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop+topInset).isActive = true
        }
        if let leftAnchor = leftAnchor {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingLeft).isActive = true
        }
        if let rightAnchor = rightAnchor {
            self.rightAnchor.constraint(equalTo: rightAnchor, constant: -paddingRight).isActive = true
        }
        if let bottomAnchor = bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -paddingBottom-bottomInset).isActive = true
        }
        if let widthAnchor = widthAnchor {
            self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
 
