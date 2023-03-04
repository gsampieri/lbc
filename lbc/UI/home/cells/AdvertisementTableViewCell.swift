//
//  AdvertisementTableViewCell.swift
//  lbc
//
//  Created by Gilles SAMPIERI on 01/03/2023.
//

import UIKit

class AdvertisementTableViewCell: UITableViewCell {
    var advertisement: Advertisement!

    // MARK: View Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        selectionStyle = .none
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentCellView.backgroundColor = highlighted ? UIColor(named: "defaultSelectedColor") : UIColor(named: "contentBackgroundColor")
    }
    
    func setAdvertisement(_ advertisement: Advertisement) {
        self.advertisement = advertisement
        setupUI()
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price.getPriceString()
        categoryLabel.text = advertisement.category.name
        
        advertisementImageView.image = UIImage(named: "lbc_advertisment_placeholder")
        if let smallImage = advertisement.smallImage {
            advertisementImageView.getImage(from: smallImage)
        }
    }
    
    // MARK: - UI
    private let padding: CGFloat = 8
    
    private var contentCellView: UIView = {
        let contentCellView = UIView()
        contentCellView.backgroundColor = UIColor(named: "contentBackgroundColor")
        contentCellView.layer.cornerRadius = 8
        return contentCellView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        priceLabel.textAlignment = .left
        return priceLabel
    }()
    
    private let categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        categoryLabel.textAlignment = .left
        return categoryLabel
    }()
    
    private var advertisementImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "lbc_advertisment_placeholder"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        imageView.layer.cornerRadius = 8
        imageView.tintColor = UIColor(named: "primaryColor")
        return imageView
    }()
    
    private let urgentView: UIView = {
        let urgentView = UIView()
        let urgentLabel = UILabel()
        urgentLabel.text = "urgent".localize.uppercased()
        urgentLabel.textAlignment = .center
        urgentLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
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
    
    private let proView: UIView = {
        let proView = UIView()
        let urgentLabel = UILabel()
        urgentLabel.text = "pro".localize.uppercased()
        urgentLabel.textAlignment = .center
        urgentLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        urgentLabel.textColor = UIColor(named: "defaultTextColor")
        proView.addSubview(urgentLabel)
        urgentLabel.anchor(topAnchor: proView.topAnchor,
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
        addSubview(contentCellView)
        for subview in [titleLabel, priceLabel, categoryLabel, advertisementImageView, urgentView] {
            contentCellView.addSubview(subview)
        }
        
        contentCellView.anchor(topAnchor: topAnchor,
                               leftAnchor: leftAnchor,
                               bottomAnchor: bottomAnchor,
                               rightAnchor: rightAnchor,
                               paddingTop: 5,
                               paddingLeft: 5,
                               paddingBottom: 5,
                               paddingRight: 5)
        backgroundColor = .clear
        contentCellView.backgroundColor = UIColor(named: "contentBackgroundColor")
        advertisementImageView.anchor(topAnchor: contentCellView.topAnchor,
                                      leftAnchor: contentCellView.leftAnchor,
                                      bottomAnchor: contentCellView.bottomAnchor,
                                      width: 100,
                                      height: 96)
        titleLabel.anchor(topAnchor: contentCellView.topAnchor,
                          leftAnchor: advertisementImageView.rightAnchor,
                          rightAnchor: contentCellView.rightAnchor,
                          paddingTop: padding,
                          paddingLeft: padding,
                          paddingRight: padding)

        categoryLabel.anchor(leftAnchor: advertisementImageView.rightAnchor,
                             bottomAnchor: priceLabel.topAnchor,
                             rightAnchor: contentCellView.rightAnchor,
                             paddingTop: 2,
                             paddingLeft: padding,
                             paddingRight: padding)

        priceLabel.anchor(leftAnchor: advertisementImageView.rightAnchor,
                          bottomAnchor: contentCellView.bottomAnchor,
                          rightAnchor: contentCellView.rightAnchor,
                          paddingLeft: padding,
                          paddingBottom: padding,
                          paddingRight: padding)

        urgentView.anchor(topAnchor: priceLabel.topAnchor,
                          bottomAnchor: priceLabel.bottomAnchor,
                          rightAnchor: contentCellView.rightAnchor,
                          paddingLeft: padding,
                          paddingRight: padding)
        urgentView.isHidden = !advertisement.isUrgent
    }
}
