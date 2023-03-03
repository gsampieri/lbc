//
//  AdvertisementTableViewCell.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import UIKit

class AdvertisementTableViewCell: UITableViewCell {

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
    
    // MARK: View Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        advertisementImageView.image = UIImage(named: "lbc_advertisment_placeholder")
        advertisementImageView.contentMode = .scaleAspectFill
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(advertisementTitleLabel)
        addSubview(advertisementPriceLabel)
        addSubview(advertisementCategoryLabel)
        addSubview(advertisementImageView)
        advertisementImageView.anchor(top: topAnchor,
                                      left: leftAnchor,
                                      bottom: bottomAnchor,
                                      right: nil,
                                      paddingTop: padding,
                                      paddingLeft: padding,
                                      paddingBottom: padding,
                                      paddingRight: 0,
                                      width: 70,
                                      height: 70,
                                      enableInsets: false)
        advertisementTitleLabel.anchor(top: topAnchor,
                                       left: advertisementImageView.rightAnchor,
                                       bottom: nil,
                                       right: rightAnchor,
                                       paddingTop: padding,
                                       paddingLeft: padding,
                                       paddingBottom: 0,
                                       paddingRight: padding,
                                       width: 0,
                                       height: 0,
                                       enableInsets: false)
        advertisementCategoryLabel.anchor(top: advertisementTitleLabel.bottomAnchor,
                                          left: advertisementImageView.rightAnchor,
                                          bottom: advertisementPriceLabel.topAnchor,
                                          right: rightAnchor,
                                          paddingTop: 2,
                                          paddingLeft: padding,
                                          paddingBottom: 2,
                                          paddingRight: padding,
                                          width: 0,
                                          height: 0,
                                          enableInsets: false)
        advertisementPriceLabel.anchor(top: nil,
                                       left: advertisementImageView.rightAnchor,
                                       bottom: bottomAnchor,
                                       right: rightAnchor,
                                       paddingTop: padding,
                                       paddingLeft: padding,
                                       paddingBottom: padding,
                                       paddingRight: padding,
                                       width: 0,
                                       height: 0,
                                       enableInsets: false)
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
        }
    }
}
