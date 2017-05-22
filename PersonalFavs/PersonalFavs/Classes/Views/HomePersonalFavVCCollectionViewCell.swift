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
    
    
    func setupViews() {
        //addSubview(view: UIView)
        self.backgroundColor = UIColor.green
        
    }
    
}
