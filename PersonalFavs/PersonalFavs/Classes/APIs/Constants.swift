//
//  Constants.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 24/5/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//



struct Config {
    
    struct CellIDs {
        static let homeVCCellID = "HomePersonalFavVCCellID"     // Home UICollectionViewController
    }
    
    struct DataSource {
        static let numberOfSectionsInCollectionHomeView = 1
        static let numberOfItemsInCollectionHomeView = 18
    }
    
    
    struct CollectionViewLayout {
        // Numer of items per row and spacing
        static let itemsPerRow = 4
        static let itemsPadding = 1.0
        
        // Minimum FlowLayout spacing/padding for line and items
        static let itemsMinimumInteritemSpacing = 0.0
        static let itemsMinimumLineSpacing = 1.0
        
        // UIEdgeInsets
        static let sectionPaddingLeft = 10.0
        static let sectionPaddingRight = 10.0
        static let sectionPaddingTop = 400.0
        static let sectionPaddingBottom = 0.0
        
    }
    
    struct Colors {
         /*
         #2E86AB // Steel Blue
         #F6F5AE // Vanilla
         #F24236 // Vermilion
         #F5F749 // Lemon Yellow
         #564138 // Dark Liver Horses
         */
        
        static let primaryBGColor = "#2E86AB"
        static let secondaryBGColor = "#F24236"
        static let primaryTextColor = "#ffffff"
        static let secondaryTextColor = "#F6F5AE"
    }
    
}
