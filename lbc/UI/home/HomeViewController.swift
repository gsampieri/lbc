//
//  HomeViewController.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Advertisements"
        makeTableView()
    }
    
    // UI
    private func makeTableView() {
        let advertisementsTableView = UITableView()
        advertisementsTableView.delegate = self
        advertisementsTableView.dataSource = self
        
        view.addSubview(advertisementsTableView)
        
        advertisementsTableView.translatesAutoresizingMaskIntoConstraints = false
        advertisementsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        advertisementsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        advertisementsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        advertisementsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        advertisementsTableView.register(AdvertisementTableViewCell.self, forCellReuseIdentifier: "advertisementCell")

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // navigationController.push
    }
}
