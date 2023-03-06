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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let advertisement {
            if let advertisementImage = advertisement.thumbImage {
                advertisementImageView.getImage(from: advertisementImage)
            }
            titleLabel.text = advertisement.title
            priceLabel.text = advertisement.price.getPriceString()
            categoryLabel.text = advertisement.category.name

            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            dateFormatter.locale = Constant.language.locale
            dateLabel.text = dateFormatter.string(from: advertisement.creationDate)
            
            if let siret = advertisement.siret {
                siretLabel.text = "\("advertisement_detail_siret_number".localize.uppercased()): \(siret)"
            }
            descriptionLabel.text = advertisement.description
        } else {
            // TODO: show some error
        }
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
        contentView.backgroundColor = UIColor(named: "contentBackgroundColor")
        contentView.layer.cornerRadius = 8
        return contentView
    }()
    
    private var advertisementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lbc_advertisment_placeholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
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
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        dateLabel.textAlignment = .left
        return dateLabel
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let descriptionTitleLabel = UILabel()
        descriptionTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionTitleLabel.textAlignment = .left
        descriptionTitleLabel.numberOfLines = 1
        descriptionTitleLabel.text = "description".localize.capitalized
        return descriptionTitleLabel
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
        categoryLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        categoryLabel.textAlignment = .left
        return categoryLabel
    }()
    
    private let separatorView: UIView = {
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(named: "defaultSeparatorColor")
        return separatorView
    }()
    
    private let urgentView: UIView = {
        let urgentView = UIView()
        let urgentLabel = UILabel()
        urgentLabel.text = "urgent".localize.uppercased()
        urgentLabel.textAlignment = .center
        urgentLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        urgentLabel.textColor = UIColor(named: "primaryColor")
        urgentView.addSubview(urgentLabel)
        urgentLabel.anchor(topAnchor: urgentView.topAnchor,
                           leftAnchor: urgentView.leftAnchor,
                           bottomAnchor: urgentView.bottomAnchor,
                           rightAnchor: urgentView.rightAnchor,
                           paddingTop: 4,
                           paddingLeft: 4,
                           paddingBottom: 4,
                           paddingRight: 4)
        urgentView.layer.borderColor = UIColor(named: "primaryColor")?.cgColor
        urgentView.layer.borderWidth = 1
        urgentView.layer.cornerRadius = 8
        return urgentView
    }()
    
    private let siretLabel: UILabel = {
        let siretLabel = UILabel()
        siretLabel.font = UIFont.systemFont(ofSize: 15)
        siretLabel.textAlignment = .left
        siretLabel.numberOfLines = 1
        return siretLabel
    }()
    
    private let proView: UIView = {
        let proView = UIView()
        let proLabel = UILabel()
        proLabel.text = "pro".localize.uppercased()
        proLabel.textAlignment = .center
        proLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        proLabel.textColor = UIColor(named: "defaultTextColor")
        proView.addSubview(proLabel)
        proLabel.anchor(topAnchor: proView.topAnchor,
                        leftAnchor: proView.leftAnchor,
                        bottomAnchor: proView.bottomAnchor,
                        rightAnchor: proView.rightAnchor,
                        paddingTop: 4,
                        paddingLeft: 4,
                        paddingBottom: 4,
                        paddingRight: 4)
        proView.layer.borderColor = UIColor(named: "defaultTextColor")?.cgColor
        proView.layer.borderWidth = 1
        proView.layer.cornerRadius = 8
        return proView
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
                                      height: view.bounds.height/2)
        
        scrollView.addSubview(contentView)
        contentView.anchor(topAnchor: advertisementImageView.bottomAnchor,
                           leftAnchor: scrollView.leftAnchor,
                           bottomAnchor: scrollView.bottomAnchor,
                           rightAnchor: scrollView.rightAnchor,
                           paddingTop: padding,
                           paddingLeft: padding,
                           paddingBottom: padding,
                           paddingRight: padding)
        
        for subview in [titleLabel, priceLabel, dateLabel, urgentView, categoryLabel, siretLabel, proView, separatorView, descriptionTitleLabel, descriptionLabel] {
            if advertisement?.siret == nil &&
                (subview == siretLabel ||
                 subview == proView) {
                continue
            }
            if !((advertisement?.isUrgent) ?? false) &&
                subview == urgentView {
                continue
            }
            contentView.addSubview(subview)
        }

        titleLabel.anchor(topAnchor: contentView.topAnchor,
                          leftAnchor: contentView.leftAnchor,
                          bottomAnchor: priceLabel.topAnchor,
                          rightAnchor: contentView.rightAnchor,
                          paddingTop: padding,
                          paddingLeft: padding,
                          paddingBottom: padding,
                          paddingRight: padding)
        
        priceLabel.anchor(leftAnchor: contentView.leftAnchor,
                          bottomAnchor: dateLabel.topAnchor,
                          rightAnchor: contentView.rightAnchor,
                          paddingLeft: padding,
                          paddingBottom: padding,
                          paddingRight: padding)

        if advertisement?.isUrgent ?? false {
            urgentView.anchor(topAnchor: priceLabel.topAnchor,
                              bottomAnchor: priceLabel.bottomAnchor,
                              rightAnchor: contentView.rightAnchor,
                              paddingLeft: padding,
                              paddingRight: padding)
        }
        dateLabel.anchor(leftAnchor: contentView.leftAnchor,
                         bottomAnchor: categoryLabel.topAnchor,
                         rightAnchor: contentView.rightAnchor,
                         paddingLeft: padding,
                         paddingRight: padding)
        categoryLabel.anchor(leftAnchor: contentView.leftAnchor,
                             bottomAnchor: advertisement?.siret == nil ? separatorView.topAnchor : siretLabel.topAnchor,
                             rightAnchor: contentView.rightAnchor,
                             paddingLeft: padding,
                             paddingBottom: padding,
                             paddingRight: padding)
        if advertisement?.siret != nil {
            siretLabel.anchor(leftAnchor: contentView.leftAnchor,
                              bottomAnchor: separatorView.topAnchor,
                              rightAnchor: contentView.rightAnchor,
                              paddingLeft: padding,
                              paddingBottom: padding)
            proView.anchor(topAnchor: siretLabel.topAnchor,
                           bottomAnchor: siretLabel.bottomAnchor,
                           rightAnchor: contentView.rightAnchor,
                           paddingLeft: padding,
                           paddingRight: padding)
        }
        separatorView.anchor(leftAnchor: contentView.leftAnchor,
                             bottomAnchor: descriptionTitleLabel.topAnchor,
                             rightAnchor: contentView.rightAnchor,
                             paddingLeft: padding,
                             paddingBottom: padding,
                             paddingRight: padding,
                             height: 1)
        descriptionTitleLabel.anchor(leftAnchor: contentView.leftAnchor,
                                     bottomAnchor: descriptionLabel.topAnchor,
                                     rightAnchor: contentView.rightAnchor,
                                     paddingLeft: padding,
                                     paddingBottom: padding/2,
                                     paddingRight: padding)
        descriptionLabel.anchor(leftAnchor: contentView.leftAnchor,
                                bottomAnchor: contentView.bottomAnchor,
                                rightAnchor: contentView.rightAnchor,
                                paddingLeft: padding,
                                paddingBottom: padding,
                                paddingRight: padding)
    }
}
