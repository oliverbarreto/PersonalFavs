//
//  HomeController.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 3/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit
import CoreData


class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    // MARK: - Model Variables
    
    fileprivate let headerCellID = "sectionHeaderCell"
    
    var timer: Timer?
    
    var dateHeaderContainerViewTopAnchorConstraint: NSLayoutConstraint? // Used to pin the datelabelContainerView to the top on the animation scrolling with UICollectionViewDidScroll update
    
//    let transitionManager = HomeViewControllerTransitionManager()


    
    // MARK: - Date Label Layout
    
    let dateHeaderContainerView: UIView = {
        let view = UIView()
        //view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 70, weight: UIFontWeightThin)
        label.textAlignment = .center
        label.text = self.getTime()
        //label.backgroundColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    @objc private func updateTime() {
        timeLabel.text = getTime()
    }
    
    private func getTime() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: now)
        
    }
    
    let dateLabel: UILabel = {
        let label = UILabel()
        
        let now = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .full
        label.text = dateFormatter.string(from: now)
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        label.textAlignment = .center
        //label.backgroundColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    // MARK: - VC lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        DataStoreManager.shared.unarchiveModel()
        setupViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Loads dummy data from the extension to load GroupsDictionary (personal, shared, recommended) and all its groups from dummy hard-coded data
        // DummyFavs are created at the moment of creating the next controller from the extension class method for each group
        printDataStoreValues()
        
        updateTime()
        
        
        // Timer Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(updateTime), name: NSNotification.Name.UIApplicationWillEnterForeground, object: UIApplication.shared)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
        
        // Memento: Add observer for Entering Background
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveCurrentState), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc private func saveCurrentState() {
        print("archiving")
        DataStoreManager.shared.archiveModel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        timer?.invalidate()
        timer = nil
    }
    
    private func printDataStoreValues() {
        // New DataStore Manager use
        print("***************************************")
        print("***************************************")
        print("***************************************")
        print("*** Printing Loaded Model ***")
        print("***************************************")
        print("***************************************")
        print("***************************************")
        
        let favFeeds = DataStoreManager.shared.getFavFeeds()
        for favFeed in favFeeds {
            print(favFeed.feedType.rawValue)
        }
        
        let personalGroups = DataStoreManager.shared.getPersonalGroups()
        for group in personalGroups {
            
            let favs = DataStoreManager.shared.getFavs(forGroup: group)
            print(group.name ?? "-Empty-")
            print(favs)
            
        }
        
        let sharedGroups = DataStoreManager.shared.getSharedGroups()
        for group in personalGroups {
            
            let favs = DataStoreManager.shared.getFavs(forGroup: group)
            print(group.name ?? "-Empty-")
            print(favs)
        }
        
        let recommendedGroups = DataStoreManager.shared.getRecommendedGroups()
        for group in personalGroups {
            
            let favs = DataStoreManager.shared.getFavs(forGroup: group)
            print(group.name ?? "-Empty-")
            print(favs)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        timer?.invalidate()
        timer = nil
    }
    
    
    
    // MARK: - UI & Autolayout Lifecycle

    func setupViews() {

        setupCollectionView()
        setupDateLabelContainerView()
    }
    
    
    func setupCollectionView() {
        
        // Register cell classes
        self.collectionView?.register(GroupCell.self, forCellWithReuseIdentifier: Config.CellIDs.homeVCCellID)
        self.collectionView?.register(GroupSectionHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCellID)
        
        // Customize
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
        
        // Set collectionview content offset to appear in the middle of the screen
        self.collectionView?.contentInset = UIEdgeInsets(top: CGFloat(Config.HomeController.DateHeaderContainerView.initialContentOffset), left: 0, bottom: 8, right: 0)
    }

    
    private func setupDateLabelContainerView() {
        // Add dateHeaderContainerView on top of the VC view, separately from collection view
        view.addSubview(dateHeaderContainerView)
        dateHeaderContainerView.addSubview(timeLabel)
        dateHeaderContainerView.addSubview(dateLabel)
        
        dateHeaderContainerViewTopAnchorConstraint = dateHeaderContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70)    //TODO: Change Magic Number with Config enum
        dateHeaderContainerViewTopAnchorConstraint?.isActive = true
        
        _ = dateHeaderContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        _ = dateHeaderContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        _ = dateHeaderContainerView.heightAnchor.constraint(equalToConstant: CGFloat(Config.HomeController.DateHeaderContainerView.dateheaderContainerViewHeight)).isActive = true
        
        
        _ = timeLabel.anchorWithSizeAndConstantsTo(top: dateHeaderContainerView.topAnchor, left: dateHeaderContainerView.leftAnchor, bottom: nil, right: dateHeaderContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 70)
        
        _ = dateLabel.anchorWithSizeAndConstantsTo(top: nil, left: dateHeaderContainerView.leftAnchor, bottom: dateHeaderContainerView.bottomAnchor, right: dateHeaderContainerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: CGFloat(Config.HomeController.DateHeaderContainerView.dateLabelHight))
    }
    
    
    
    // MARK: - ScrollView Delegate
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        
        var delta:CGFloat = 0
        delta = fabs(offset - (-CGFloat(Config.HomeController.DateHeaderContainerView.initialContentOffset)))
        
        var constant = delta
        constant = CGFloat(Config.HomeController.DateHeaderContainerView.dateheaderContainerViewTopMargin) - delta

        var headerTransform = CATransform3DIdentity
        

        if offset < -CGFloat(Config.HomeController.DateHeaderContainerView.initialContentOffset)  {
        
            if dateHeaderContainerViewTopAnchorConstraint != nil {
                dateHeaderContainerViewTopAnchorConstraint?.isActive = false
                dateHeaderContainerViewTopAnchorConstraint =
                    dateHeaderContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
                dateHeaderContainerViewTopAnchorConstraint?.isActive = true
            }
            
            
            let headerScaleFactor:CGFloat = max(-(offset+CGFloat(Config.HomeController.DateHeaderContainerView.initialContentOffset)) / dateHeaderContainerView.bounds.height, 0.2)
            let headerSizevariation = ((dateHeaderContainerView.bounds.height * (1.0 + headerScaleFactor)) - dateHeaderContainerView.bounds.height)/2.0
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            dateHeaderContainerView.layer.transform = headerTransform
            
        } else {
            
            if dateHeaderContainerViewTopAnchorConstraint != nil {
                dateHeaderContainerViewTopAnchorConstraint?.isActive = false
                dateHeaderContainerViewTopAnchorConstraint =
                    dateHeaderContainerView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant)
                dateHeaderContainerViewTopAnchorConstraint?.isActive = true
            }
        }
    }
}

extension HomeController {
    
    // MARK: - UICollectionViewController DataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return DataStoreManager.shared.getFavFeeds().count

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return DataStoreManager.shared.getPersonalGroups().count
        case 1:
            return DataStoreManager.shared.getSharedGroups().count
        case 2:
            return DataStoreManager.shared.getRecommendedGroups().count
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Config.CellIDs.homeVCCellID, for: indexPath) as! GroupCell
        
        let section = indexPath.section
        
        switch section {
        case 0:
            cell.group = DataStoreManager.shared.getPersonalGroups()[indexPath.item]
        case 1:
            cell.group = DataStoreManager.shared.getSharedGroups()[indexPath.item]
        case 2:
            cell.group = DataStoreManager.shared.getRecommendedGroups()[indexPath.item]
        default:
            return cell
        }

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerCellID, for: indexPath) as! GroupSectionHeaderCell
            header.backgroundColor = UIColor.white
        
            let section = indexPath.section

            switch section {
            case 0:
                header.sectionName = FavFeed.FeedType.personal.rawValue
            case 1:
                header.sectionName = FavFeed.FeedType.shared.rawValue
            case 2:
                header.sectionName = FavFeed.FeedType.recommended.rawValue
            default:
                return header
            }

            return header
        
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let favController = FavsController(collectionViewLayout: layout)
//        favController.transitioningDelegate = self.transitionManager
        
        
        let section = indexPath.section
        
        switch section {
        case 0:
            let group = DataStoreManager.shared.getPersonalGroups()[indexPath.item]
            favController.group = group
            favController.title = group.name
            favController.favs = DataStoreManager.shared.getFavs(forGroup: group)
        case 1:
            let group = DataStoreManager.shared.getSharedGroups()[indexPath.item]
            favController.group = group
            favController.title = group.name
            favController.favs = DataStoreManager.shared.getFavs(forGroup: group)
        case 2:
            let group = DataStoreManager.shared.getRecommendedGroups()[indexPath.item]
            favController.group = group
            favController.title = group.name
            favController.favs = DataStoreManager.shared.getFavs(forGroup: group)
        default:
            return
        }
        
        let navigationVC = UINavigationController(rootViewController: favController)
//        navigationVC.delegate = NavDelegate()
        self.present(navigationVC, animated: true)
        //navigationController?.pushViewController(favController, animated: true)
    }
}


extension HomeController {
    
    //MARK: - UICollectionView FlowLayout Delegate
    
    // Custom Layout for Cells  - Size for Cell items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width - CGFloat(Config.CollectionViewLayout.HomeVC.groupCardPaddingLeft) - CGFloat(Config.CollectionViewLayout.HomeVC.groupCardPaddingRight), height: 150
            
        )
    }
    
    // Custom Layout for Headers  - Size for Headers within sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: view.frame.width, height: CGFloat(Config.CollectionViewLayout.HomeVC.groupCardHeaderHeightSize))
    }
    
    
    // Custom Layout for sections - Spacing between items within sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(Config.CollectionViewLayout.HomeVC.itemsMinimumInteritemSpacing)
        
    }
    
    // Custom Layout for sections - Spacing between lines within sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(Config.CollectionViewLayout.HomeVC.itemsMinimumLineSpacing)
    }
    
    
    // Custom Layout for sections - EdgeInsets
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 12, left: 0, bottom: 10, right: 0)
    }
}






