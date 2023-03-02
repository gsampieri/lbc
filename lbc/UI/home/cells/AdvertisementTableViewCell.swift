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
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let advertisementPriceLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textAlignment = .left
        return descriptionLabel
    }()
    
    private let advertisementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: ""))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
       
    
    // MARK: View Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(advertisementTitleLabel)
        addSubview(advertisementPriceLabel)
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

    func setAdvertisement(_ advertisement: Advertisement) { // TODO: edit Object
        advertisementTitleLabel.text = advertisement.title
        advertisementPriceLabel.text = advertisement.price.getPriceString()

        if let smallImage = advertisement.smallImage {
            advertisementImageView.getImage(from: smallImage)
        }
//        advertisementDescriptionLabel.text = advertisementDescriptionLabel.t
    }
}
