//
//  HomeViewController.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import UIKit

class HomeViewController: UIViewController {
    let advertisementsTableView = UITableView()
    var advertisements: [Advertisement] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        title = "advertisements".localize.capitalized
        
        makeTableView()
        getAdvertisements()
    }
    
    private func getAdvertisements() {
        refreshControl.beginRefreshing()
        restManager.getAdvertisementsCategories { [weak self] advertisements, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.refreshControl.endRefreshing()
                    let errorAlert = UIAlertController(title: "error".localize.capitalized,
                                                       message: error.localizedDescription,
                                                       preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self?.present(errorAlert, animated: true)
                }
                return
            }
            if let advertisements = advertisements {
                self?.advertisements = advertisements
            }
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.advertisementsTableView.reloadData()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        getAdvertisements()
    }
    
    // MARK: - UI
    private func makeTableView() {
        advertisementsTableView.delegate = self
        advertisementsTableView.dataSource = self
        advertisementsTableView.separatorColor = .clear
        advertisementsTableView.refreshControl = refreshControl
        view.addSubview(advertisementsTableView)
        
        advertisementsTableView.anchor(topAnchor: view.topAnchor,
                                       leftAnchor: view.leftAnchor,
                                       bottomAnchor: view.bottomAnchor,
                                       rightAnchor: view.rightAnchor)
        advertisementsTableView.backgroundColor = UIColor(named: "defaultBackgroundColor")
        advertisementsTableView.register(AdvertisementTableViewCell.self, forCellReuseIdentifier: "advertisementCell")
    }
    
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(named: "primaryColor")
        refreshControl.showsLargeContentViewer = true
        refreshControl.addTarget(nil, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "advertisementCell", for: indexPath) as? AdvertisementTableViewCell {
            cell.setAdvertisement(advertisements[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if UIDevice.current.userInterfaceIdiom == .pad &&
            traitCollection.verticalSizeClass == .regular,
           let detailViewController = (navigationController?.splitViewController?.viewControllers.last as? UINavigationController)?.viewControllers.first as? DetailViewController {

            detailViewController.advertisement = advertisements[indexPath.row]
            detailViewController.fillData()
            detailViewController.setupUI()
        } else {
            navigationController?.pushViewController(DetailViewController(with: advertisements[indexPath.row]), animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - RestManagerDependant
extension HomeViewController: RestManagerDependant {}
