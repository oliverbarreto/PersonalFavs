//
//  HomePersonalFavVCCollectionViewCell.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 22/5/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class FavCell: BaseCell {
    
    // MARK: - Model
    
    //Fav(givenName: "Oliver", familyName: "Barreto", value: "+34610700505", tag: "personal", type: "phone", imageName:"Oliver", group: group)
    var fav: Fav? {
        didSet {
            updateUI()
        }
    }
    
    
    // MARK: - Properties
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Oliver")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = CGFloat(self.frame.width / 2)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let typeiconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "TypeIcon_Phone")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    let typeLabel:UILabel = {
        let label = UILabel()
        label.text = "type"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFontWeightLight)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "name"
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Custom Methods
    
    override func setupViews() {
        
//        self.backgroundColor = UIColor.blue
        self.addSubview(thumbnailImageView)
        self.addSubview(typeiconImageView)
        self.addSubview(typeLabel)
        self.addSubview(nameLabel)
        
        
        _ = thumbnailImageView.anchorWithSizeAndConstantsTo(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        _ = thumbnailImageView.widthAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
        _ = thumbnailImageView.heightAnchor.constraint(equalTo: widthAnchor, constant: 0).isActive = true
        

        _ = typeiconImageView.anchorWithSizeAndConstantsTo(top: thumbnailImageView.bottomAnchor, left: nil, bottom: nil, right: nil, topConstant: -10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        _ = typeiconImageView.centerXAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor, constant: 0).isActive = true
        
        
        _ = typeLabel.anchorWithSizeAndConstantsTo(top: typeiconImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        _ = nameLabel.anchorWithSizeAndConstantsTo(top: typeLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    private func updateUI () {
//        print("Update UI")
//        print((fav?.imageName)!)
//        print((fav?.givenName)!)
        
        // Update UI according to cell model
        thumbnailImageView.image = UIImage(named: (fav?.imageName)!)
        typeiconImageView.image = UIImage(named: ("TypeIcon_\((fav?.type)!)"))
        typeLabel.text = (fav?.type)!
        nameLabel.text = (fav?.givenName)!
        
    }
    
    

    
}
