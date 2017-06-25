//
//  GroupCell.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 4/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class GroupCell: BaseCell {
    
    // MARK: Model
    var group: Group? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        groupTitle.text = group?.name!
        
        if let image = UIImage(named: (group?.iconPath!)!) {
            groupIcon.image = image.withRenderingMode(.alwaysTemplate)
        } else {
            let image = #imageLiteral(resourceName: "Icon_FriendsGroup3").withRenderingMode(.alwaysTemplate)
            groupIcon.image = image
        }
        
        let color = UIColor(hex: (group?.color!)!)
        self.backgroundColor = color
    }
    

    // MARK: - View & Autolayout Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        self.backgroundColor = UIColor.orange
        self.layer.cornerRadius = 5
        
    }
    
    
    // MARK: - Layout Lifecycle Custom Methods
    
    lazy var groupTitle: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Family"
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: UIFontWeightLight)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
//        titleLabel.backgroundColor = UIColor.red
        return titleLabel
    }()
    
    let groupIcon: UIImageView = {
        let imageView = UIImageView()
        let image = #imageLiteral(resourceName: "Icon_Family").withRenderingMode(.alwaysTemplate)
        imageView.image = image
        
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor.white
//        imageView.backgroundColor = UIColor.black
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    // MARK: - Custom methods
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(groupTitle)
        addSubview(groupIcon)
        
        _ = groupTitle.anchorWithSizeAndConstantsTo(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: CGFloat(Config.CollectionViewLayout.HomeVC.groupCardPaddingTop), leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        _ = groupIcon.anchorWithSizeAndConstantsTo(top: groupTitle.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: CGFloat(Config.CollectionViewLayout.HomeVC.groupCardPaddingBottom), rightConstant: 0, widthConstant: 0, heightConstant: 60)
        
    }

}
