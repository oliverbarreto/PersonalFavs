//
//  HomePersonalFavVCCollectionViewCell.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 22/5/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class HomePersonalFavVCCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(hex: Config.Colors.secondaryBGColor)
        
        return imageView
    }()
    
    let label:UILabel = {
       let mylabel = UILabel()
        mylabel.text = "label"
        mylabel.translatesAutoresizingMaskIntoConstraints = false
        mylabel.textColor = UIColor(hex: Config.Colors.secondaryTextColor)

        return mylabel
    }()
    
    func setupViews() {
        self.addSubview(thumbnailImageView)
        self.addSubview(label)
        
        let margins = thumbnailImageView.layoutMarginsGuide
        
        thumbnailImageView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        
        label.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor, constant: 0).isActive = true
    }
    
}
