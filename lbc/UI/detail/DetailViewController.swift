//
//  DetailViewController.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import UIKit

class DetailViewController: UIViewController {
    var advertisement: Advertisement?
    
    convenience init(with advertisement: Advertisement) {
        self.init()
        
        self.advertisement = advertisement
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}

