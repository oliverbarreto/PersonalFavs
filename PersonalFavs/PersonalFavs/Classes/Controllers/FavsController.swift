//
//  FavsController.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 11/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class FavsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Model
    
    var group: Group? {
        didSet {
            updateUI()
        }
    }
    
    var favs: [Fav]? {
        didSet {
            updateUI()
        }
    }
    
    
    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = UIColor.white
        
        setupViews()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Memento: Add observer for Entering Background
        NotificationCenter.default.addObserver(self, selector: #selector(self.saveCurrentState), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    @objc private func saveCurrentState() {
        print("archiving")
        DataStoreManager.shared.archiveModel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    
    
    //MARK: - Custom Methods
    
    func setupGestures() {
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenEdgeSwiped))
        edgePan.edges = .left
        
        view.addGestureRecognizer(edgePan)
    }
    
    func updateUI() {
        //
    }
    
    func setupViews(){
        customNavBar()
        
        setupCollectionView()
        setupCustomLayout()
        
        updateUI()
    }
    
    private func setupCollectionView() {
        // Register cell classes
        self.collectionView?.register(FavCell.self, forCellWithReuseIdentifier: Config.CellIDs.favsCellID)
        
        // Customize
        self.collectionView?.backgroundColor = UIColor(hex: Config.Colors.FlatColors.porcelain)
        
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func setupCustomLayout() {
        
        // Setup custom layout
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(
            top: CGFloat(Config.CollectionViewLayout.FavsVC.sectionPaddingTop),
            left: CGFloat(Config.CollectionViewLayout.FavsVC.sectionPaddingLeft),
            bottom: CGFloat(Config.CollectionViewLayout.FavsVC.sectionPaddingBottom),
            right: CGFloat(Config.CollectionViewLayout.FavsVC.sectionPaddingRight))
        
        layout.minimumInteritemSpacing = CGFloat(Config.CollectionViewLayout.FavsVC.itemsMinimumInteritemSpacing)
        layout.minimumLineSpacing = CGFloat(Config.CollectionViewLayout.FavsVC.itemsMinimumLineSpacing)
        
        self.collectionView?.collectionViewLayout = layout
    }


    func customNavBar() {
        
        if let group = group {
            navigationItem.title = group.name
        }
        
        
        // Navbar Tint Colors
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // Set Navbar Background color to group color
        if let color = group?.color {
            UINavigationBar.appearance().barTintColor = UIColor(hex: color)
        }

        // TODO: Custom StatusBar Mode depending on the background color type
        // Applicacion Info.plist must be edite and inlude ViewController based satatus bar = true
        //UIApplication.shared.statusBarStyle = .default
        
        // Hide Back button and create a custom one
        self.navigationItem.hidesBackButton = true
        
   
        //let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(backButtonPressed))
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Icon_GroupMenuLined").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let editButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Icon_3PointsBackButton").withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(editButtonPressed))
        self.navigationItem.rightBarButtonItem = editButton
    }

    func editButtonPressed() {
        //
    }

    func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    func screenEdgeSwiped(recognizer: UIScreenEdgePanGestureRecognizer) {
        if recognizer.state  == .recognized {
            backButtonPressed()
        }
    }
    
    
    
    // MARK: - CollectionView DataSource Protocol
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favs?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Config.CellIDs.favsCellID, for: indexPath) as! FavCell
        
        cell.fav = favs?[indexPath.item]
        
        //cell.backgroundColor = UIColor.clear
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        guard let favValue = favs?[indexPath.item].value else { return }
        guard let favType = favs?[indexPath.item].type else {return }
        
        executeAction(ofType: favType, withValue: favValue)
    }
    
    private func executeAction(ofType type: String, withValue value: String) {
        /*
         eMail
         FaceTime
         FaceTimeAudio
         Phone
         Text
         Whatsapp
        */
        
        var actionURLScheme = ""
        
        switch type {
        case "Phone", "iPhone":
            actionURLScheme = "tel"
            executeStandard(actionURLScheme: actionURLScheme, forValue: value)
        case "Text":
            actionURLScheme = "sms"
            executeText(actionURLScheme: actionURLScheme, forValue: value)
        case "eMail":
            actionURLScheme = "mailto"
            executeStandard(actionURLScheme: actionURLScheme, forValue: value)
        case "FaceTime":
            actionURLScheme = "facetime"
            executeStandard(actionURLScheme: actionURLScheme, forValue: value)
        case "FaceTimeAudio":
            actionURLScheme = "facetime-audio"
            executeStandard(actionURLScheme: actionURLScheme, forValue: value)
        case "Web":
            actionURLScheme = "http"
            executeStandard(actionURLScheme: actionURLScheme, forValue: value)
        case "Map":
            actionURLScheme = "http"
            executeStandard(actionURLScheme: actionURLScheme, forValue: value)
            //http://maps.apple.com/?address=1,Infinite+Loop,Cupertino,California
        case "Whatsapp":
            actionURLScheme = "whatsapp"
            executeWhatsapp(actionURLScheme: actionURLScheme, forValue: value)
        default:
            print("type action not available")
        }
        
    }
    
    // MARK: - Actions
    
    // Checks whether an app URLScheme is available on the device (the app is installed). after adding LSApplicationQueriesSchemes key toinfo.plist
    private func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    private func executeStandard(actionURLScheme: String, forValue value: String) {
        if let actionURL:NSURL = NSURL(string:"\(actionURLScheme)://\(value)") {
            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(actionURL as URL)) {
//                application.open(actionURL as URL, options: [:], completionHandler: nil)
//                //application.openURL(phoneCallURL as URL)
//            }
            if (application.canOpenURL(actionURL as URL)) {
                application.open(actionURL as URL, options: [:]) { success in
                    print("Open \(actionURLScheme) openned = \(success) ")
                }
            }
        }
    }
    
    private func executeText(actionURLScheme: String, forValue value: String) {
        if let actionURL:NSURL = NSURL(string:"\(actionURLScheme):\(value)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(actionURL as URL)) {
                application.open(actionURL as URL, options: [:], completionHandler: nil)
                //application.openURL(phoneCallURL as URL)
            }
        }
    }
    
    private func executeWhatsapp(actionURLScheme: String, forValue value: String) {
        if let actionURL:NSURL = NSURL(string:"\(actionURLScheme)://send?text=Hello") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(actionURL as URL)) {
                application.open(actionURL as URL, options: [:], completionHandler: nil)
                //application.openURL(phoneCallURL as URL)
            }
        }
//        if let actionURL:NSURL = 
//          NSURL(string:whatsapp://send?abid=Miguel&amp;text=Hola!") {
//        where abid is the AdderssBook Contact ID
    }
    
    private func callNumber(phoneNumber:String) {
        // TODO: consider analyzing phone string to check where is callable or not before passing it to the  phone app.
        
        if let phoneCallURL:NSURL = NSURL(string:"tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL as URL)) {
                application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
                //application.openURL(phoneCallURL as URL)
            }
        }
    }
    
    private func sendMail(eMail: String) {
        
        if let eMailCallURL:NSURL = NSURL(string:"mailto://\(eMail)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(eMailCallURL as URL)) {
                application.open(eMailCallURL as URL, options: [:], completionHandler: nil)
            }
        }
    }
    

    
    // MARK: - CollectionView Delegate Protocol
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Calculate the size of each item based on Config.CollectionViewLayout constants
        let paddingSpace = Config.CollectionViewLayout.FavsVC.sectionPaddingLeft + Config.CollectionViewLayout.FavsVC.sectionPaddingRight + (Double((Config.CollectionViewLayout.FavsVC.itemsPerRow - 1)) * Config.CollectionViewLayout.FavsVC.itemsMinimumInteritemSpacing)
        let width = view.frame.width - CGFloat(paddingSpace)
        let widthPerItem = width / CGFloat(Config.CollectionViewLayout.FavsVC.itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem + 60)
        //return CGSize(width: widthPerItem, height: widthPerItem + CGFloat(Config.PersonalFavCell.typelabelHeight) + CGFloat(Config.PersonalFavCell.namelabelHeight))
    }
}


extension FavsController {
    
    
    //MARK: - UICollectionView FlowLayout Delegate
    
    // Custom Layout for sections - Spacing between items within sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(Config.CollectionViewLayout.FavsVC.itemsMinimumInteritemSpacing)
    }
    
    // Custom Layout for sections - Spacing between lines within sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return CGFloat(Config.CollectionViewLayout.FavsVC.itemsMinimumLineSpacing)
    }
}



