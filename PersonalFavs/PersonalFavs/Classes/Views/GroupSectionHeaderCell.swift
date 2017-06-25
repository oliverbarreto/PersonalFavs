//
//  GroupSectionHeaderCell.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 11/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class GroupSectionHeaderCell: UICollectionReusableView {
    
    // MARK: - Model
    
    var sectionName: String? {
        didSet {
           sectionTitle.text = sectionName
        }
    }
    
    
    
    //MARK: - View Lifecycle
    
    let sectionTitle: UILabel = {
        let title = UILabel()
        title.text = "personal"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let sectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
        button.backgroundColor = UIColor.clear
        button.setImage(#imageLiteral(resourceName: "Icon_Add").withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addButtonActionPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Custom
    
    func setupViews() {
        
        addSubview(sectionTitle)
        addSubview(sectionButton)
        
        _ = sectionTitle.anchorWithSizeAndConstantsTo(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, topConstant: 0, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        _ = sectionButton.anchorWithSizeAndConstantsTo(top: nil, left: nil, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 24, heightConstant: 24)
    }
    

    func addButtonActionPressed(sender: UIButton) {
        print("add button pressed")
    }
}
