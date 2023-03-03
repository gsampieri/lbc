//
//  AdvertisementTableViewCell.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import UIKit

class AdvertisementTableViewCell: UITableViewCell {
    
    // MARK: View Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        selectionStyle = .none
        advertisementImageView.image = nil
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAdvertisement(_ advertisement: Advertisement) {
        advertisementTitleLabel.text = advertisement.title
        advertisementPriceLabel.text = advertisement.price.getPriceString()
        advertisementCategoryLabel.text = advertisement.category.name
        
        if let smallImage = advertisement.smallImage {
            advertisementImageView.getImage(from: smallImage)
        } else {
            advertisementImageView.image = UIImage(named: "lbc_advertisment_placeholder")
        }
    }
    
    // MARK: - UI
    private let padding: CGFloat = 8
    
    private let advertisementTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let advertisementPriceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.textAlignment = .left
        return priceLabel
    }()
    
    private let advertisementCategoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.boldSystemFont(ofSize: 14)
        categoryLabel.textAlignment = .left
        return categoryLabel
    }()
    
    private var advertisementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lbc_advertisment_placeholder"))
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.tintColor = UIColor(named: "primary")
        return imageView
    }()
    
    private func setupUI() {
        addSubview(advertisementTitleLabel)
        addSubview(advertisementPriceLabel)
        addSubview(advertisementCategoryLabel)
        addSubview(advertisementImageView)
        advertisementImageView.anchor(topAnchor: topAnchor,
                                      leftAnchor: leftAnchor,
                                      bottomAnchor: bottomAnchor,
                                      paddingTop: padding,
                                      paddingLeft: padding,
                                      paddingBottom: padding,
                                      width: 70,
                                      height: 70)
        advertisementTitleLabel.anchor(topAnchor: topAnchor,
                                       leftAnchor: advertisementImageView.rightAnchor,
                                       rightAnchor: rightAnchor,
                                       paddingTop: padding,
                                       paddingLeft: padding,
                                       paddingRight: padding)
        advertisementCategoryLabel.anchor(topAnchor: advertisementTitleLabel.bottomAnchor,
                                          leftAnchor: advertisementImageView.rightAnchor,
                                          bottomAnchor: advertisementPriceLabel.topAnchor,
                                          rightAnchor: rightAnchor,
                                          paddingTop: 2,
                                          paddingLeft: padding,
                                          paddingBottom: 2,
                                          paddingRight: padding)
        advertisementPriceLabel.anchor(topAnchor: nil,
                                       leftAnchor: advertisementImageView.rightAnchor,
                                       bottomAnchor: bottomAnchor,
                                       rightAnchor: rightAnchor,
                                       paddingTop: padding,
                                       paddingLeft: padding,
                                       paddingBottom: padding,
                                       paddingRight: padding)
    }
}
