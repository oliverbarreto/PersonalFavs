//
//  BaseCell.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 9/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupViews() {}
    
}
