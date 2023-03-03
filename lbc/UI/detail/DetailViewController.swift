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
        setupUI()
//        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let advertisement {
            if let advertisementImage = advertisement.thumbImage {
                advertisementImageView.getImage(from: advertisementImage)
            }
            titleLabel.text = advertisement.title
            descriptionLabel.text = advertisement.description
        }
        // Do any additional setup after loading the view.
    }
    

    // MARK: - UI
    private let padding: CGFloat = 12

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .red
        return contentView
    }()
    
    private var advertisementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lbc_advertisment_placeholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.layer.cornerRadius = 8
        imageView.tintColor = UIColor(named: "primary")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.textAlignment = .left
        return priceLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 16)
        categoryLabel.textAlignment = .left
        return categoryLabel
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "defaultSeparatorColor")
        return separatorView
    }()
    
    private func setupUI() {
        view.backgroundColor = UIColor(named: "defaultBackgroundColor")
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.anchor(topAnchor: view.topAnchor,
                          leftAnchor: view.leftAnchor,
                          bottomAnchor: view.bottomAnchor,
                          rightAnchor: view.rightAnchor,
                          widthAnchor: view.widthAnchor)

        scrollView.addSubview(advertisementImageView)
        advertisementImageView.anchor(topAnchor: scrollView.topAnchor,
                                      leftAnchor: scrollView.leftAnchor,
                                      bottomAnchor: nil,
                                      rightAnchor: scrollView.rightAnchor,
                                      widthAnchor:  scrollView.widthAnchor,
                                      height: 300)
        
        scrollView.addSubview(contentView)
        contentView.anchor(topAnchor: advertisementImageView.bottomAnchor,
                           leftAnchor: scrollView.leftAnchor,
                           bottomAnchor: scrollView.bottomAnchor,
                           rightAnchor: scrollView.rightAnchor,
                           paddingTop: padding,
                           paddingLeft: padding,
                           paddingBottom: padding,
                           paddingRight: padding)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        titleLabel.anchor(topAnchor: contentView.topAnchor,
                          leftAnchor: contentView.leftAnchor,
                          bottomAnchor: descriptionLabel.topAnchor,
                          rightAnchor: contentView.rightAnchor)
        
        descriptionLabel.anchor(topAnchor: titleLabel.bottomAnchor,
                                leftAnchor: contentView.leftAnchor,
                                bottomAnchor: contentView.bottomAnchor,
                                rightAnchor: contentView.rightAnchor,
                                paddingTop: padding,
                                paddingBottom: padding)
    }
}
