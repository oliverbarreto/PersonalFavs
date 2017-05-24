//
//  HomeCollectionViewController.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 22/5/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

private let reuseIdentifier = "HomePersonalFavVCCellID"

class HomeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(HomePersonalFavVCCollectionViewCell.self, forCellWithReuseIdentifier: Config.CellIDs.homeVCCellID)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: - VC Lifecycle

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    //MARK: - Custom Methods
    
    private func setupView() {
        
        // Properly setup the UICollectionViewFlowLayout
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        
        setupCustomLayout()
        
        // Setup NavigationBar
        navigationItem.title = "Family"
        
        // Setup VC
        collectionView?.backgroundColor = UIColor(hex: Config.Colors.primaryBGColor)
    }

    private func setupCustomLayout() {
        
        // Setup the layout config for UIEdgeInsets for the UICollectionView items. The size of each item will be calculated later in the delegate method instead of setting the size in the layout setup with layout.itemSize = CGSize(...)
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: CGFloat(Config.CollectionViewLayout.sectionPaddingTop), left: CGFloat(Config.CollectionViewLayout.sectionPaddingLeft), bottom: CGFloat(Config.CollectionViewLayout.sectionPaddingBottom), right: CGFloat(Config.CollectionViewLayout.sectionPaddingRight))
        layout.minimumInteritemSpacing = CGFloat(Config.CollectionViewLayout.itemsMinimumInteritemSpacing)
        layout.minimumLineSpacing = CGFloat(Config.CollectionViewLayout.itemsMinimumLineSpacing)
        //layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        
        self.collectionView?.collectionViewLayout = layout
        
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Config.DataSource.numberOfSectionsInCollectionHomeView
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Config.DataSource.numberOfItemsInCollectionHomeView
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Config.CellIDs.homeVCCellID, for: indexPath) as! HomePersonalFavVCCollectionViewCell
    
        // Configure the cell
        cell.backgroundView?.backgroundColor = UIColor.black
        cell.label.text = String(indexPath.item + 1)
        
        return cell
    }

    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        // Calculate the size of each item based on Config.CollectionViewLayout constants
        let paddingSpace = Config.CollectionViewLayout.sectionPaddingLeft + Config.CollectionViewLayout.sectionPaddingRight + (Double((Config.CollectionViewLayout.itemsPerRow - 1)) * Config.CollectionViewLayout.itemsPadding)
        let width = view.frame.width - CGFloat(paddingSpace)
        let widthPerItem = width / CGFloat(Config.CollectionViewLayout.itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
 

/*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
*/
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
