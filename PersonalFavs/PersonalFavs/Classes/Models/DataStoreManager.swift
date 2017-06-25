//
//  DataStoreManager.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 23/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import Foundation

class DataStoreManager {
    
    // MARK: - Shared Singleton Instance
    static let shared = DataStoreManager()

    // MARK: Init -  It is a private init, it's singleton
    private init() {
//        initWithDummyValues()
    }
    
    
    // MARK: - Internal Storage
    private var favFeeds:[FavFeed]         = []
    private var personalGroups:[Group]     = []
    private var sharedGroups:[Group]       = []
    private var recommendedGroups:[Group]  = []

    private var favs: [Fav]                = []
    
    
    // Persistency
    let personalGroupsFileName = "personalGroupsDataFile"
    let sharedGroupsFileName = "sharedGroupsDataFile"
    let recommendedGroupsFileName = "recommendedGroupsDataFile"
    let favsFileName = "favsDataFile"

    
    // MARK: - FavFeeds Group CRUD Methods
    func getFavFeeds() -> [FavFeed] {
        return favFeeds
    }
    
    
    // MARK: - Personal Group CRUD Methods
    func getPersonalGroups() -> [Group] {
        return personalGroups
    }
    
    func deletePersonalGroup(atIndex index: Int) {
        if (personalGroups.count >= index) {
            personalGroups.remove(at: index)
        }
    }
    
    func addPersonalGroup(group: Group, atIndex index: Int) {
        if (personalGroups.count >= index) {
            personalGroups.append(group)
        } else {
            personalGroups.insert(group, at: index)
        }
    }
    
    
    // MARK: - Shared Group CRUD Methods
    func getSharedGroups() -> [Group] {
        return sharedGroups
    }
    
    func deleteSharedGroup(atIndex index: Int) {
        if (sharedGroups.count >= index) {
            sharedGroups.remove(at: index)
        }
    }
    
    func addSharedGroup(group: Group, atIndex index: Int) {
        if (sharedGroups.count >= index) {
            sharedGroups.append(group)
        } else {
            sharedGroups.insert(group, at: index)
        }
    }
    
    
    // MARK: - Recommended Group CRUD Methods
    func getRecommendedGroups() -> [Group] {
        return recommendedGroups
    }
    
    func deleteRecommendedGroup(atIndex index: Int) {
        if (recommendedGroups.count >= index) {
            recommendedGroups.remove(at: index)
        }
    }
    
    func addRecommendedGroup(group: Group, atIndex index: Int) {
        if (recommendedGroups.count >= index) {
            recommendedGroups.append(group)
        } else {
            recommendedGroups.insert(group, at: index)
        }
    }
    

    
    // MARK: - Favs CRUD Methods
    func getFavs() -> [Fav] {
        return favs
    }
    
    func getFavs(forGroup group: Group) -> [Fav] {
        let found = favs.filter({ $0.groupName == group.name })
        return found
    }
    
    func deleteFav(atIndex index: Int) {
        favs.remove(at: index)
    }
    
    func addFav(fav: Fav, atIndex index: Int) {
        favs.insert(fav, at: index)
    }
    
    
    // MARK: - Utility Methods: Persistency
    
    func archiveModel () {
        // Persist using Archiving/Unarchiving Objetcs to filesystem
        let filemanager = FileManager.default
        

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            print("*** Writing ***")
            var filepath = dir.appendingPathComponent(personalGroupsFileName)
            var data = NSKeyedArchiver.archivedData(withRootObject: personalGroups)
            
            filemanager.createFile(atPath: filepath.path, contents: data, attributes: nil)
            
            
            filepath = dir.appendingPathComponent(sharedGroupsFileName)
            data = NSKeyedArchiver.archivedData(withRootObject: sharedGroups)
            
            filemanager.createFile(atPath: filepath.path, contents: data, attributes: nil)
            
            
            filepath = dir.appendingPathComponent(recommendedGroupsFileName)
            data = NSKeyedArchiver.archivedData(withRootObject: recommendedGroups)
            
            filemanager.createFile(atPath: filepath.path, contents: data, attributes: nil)
            
            
            filepath = dir.appendingPathComponent(favsFileName)
            data = NSKeyedArchiver.archivedData(withRootObject: favs)
            
            filemanager.createFile(atPath: filepath.path, contents: data, attributes: nil)
        }
    }
    
    
    func unarchiveModel() {
        let filemanager = FileManager.default
        
        
        if let dir = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            print("*** Reading ***")
            var filepath = dir.appendingPathComponent(personalGroupsFileName)
            
            guard let readPersonalGroups = NSKeyedUnarchiver.unarchiveObject(withFile: filepath.path) as? [Group] else { return }
            print(readPersonalGroups)
            
            filepath = dir.appendingPathComponent(sharedGroupsFileName)
            guard let readSharedGroups = NSKeyedUnarchiver.unarchiveObject(withFile: filepath.path) as? [Group] else { return }
            print(readSharedGroups)
            
            filepath = dir.appendingPathComponent(recommendedGroupsFileName)
            guard let readRecommendedGroups = NSKeyedUnarchiver.unarchiveObject(withFile: filepath.path) as? [Group] else { return }
            print(readRecommendedGroups)
            
            filepath = dir.appendingPathComponent(favsFileName)
            guard let readFavs = NSKeyedUnarchiver.unarchiveObject(withFile: filepath.path) as? [Fav] else { return }
            print("*** Reading Favs from disk ***")
            print(readFavs)


            // Uncomment if it is not the first run of the app and you don't need to preload data model
            personalGroups = readPersonalGroups
            sharedGroups = readSharedGroups
            recommendedGroups = readRecommendedGroups
            favs = readFavs
            print(favs)
        }
    }
    
    
    // MARK: - Utility Methods: Dummy DataBase
    
    func initWithDummyValues() {
        loadFavFeeds()
        
        // Load Dummy Groups
        personalGroups = loadDummyGroups(withFeedType: .personal)
        sharedGroups = loadDummyGroups(withFeedType: .shared)
        
        recommendedGroups = loadDummyGroups(withFeedType: .recommended)
        
        // Load Dummy Favs for all groups
        for group in personalGroups {
            loadDummyFavs(forGroup: group)
        }
        for group in sharedGroups {
            loadDummyFavs(forGroup: group)
        }
        for group in recommendedGroups{
            loadDummyFavs(forGroup: group)
        }
    }
    
    func loadFavFeeds() {
        favFeeds =  [FavFeed(feedType: .personal), FavFeed(feedType: .shared),FavFeed(feedType: .recommended)]
    }
    
    func loadDummyGroups(withFeedType feedType: FavFeed.FeedType) -> [Group] {
        
        let family = Group(name: "Family", color: Config.Colors.FlatColors.carrot, iconPath: "Icon_Family")
        let work = Group(name: "Work", color: Config.Colors.FlatColors.peterRiver, iconPath: "Icon_Work")
        let gym = Group(name: "Gym", color: Config.Colors.FlatColors.wisteria, iconPath: "Icon_Gym")
        let bday = Group(name: "Miguel's Birthday", color: Config.Colors.FlatColors.midnightBlue, iconPath: "Icon_GroupOfFriends")
        let wwdc = Group(name: "WWDC 2017", color: Config.Colors.FlatColors.orange, iconPath: "Icon_GroupOfFriends")
        let team = Group(name: "Nautico Team Party", color: Config.Colors.FlatColors.greenSea, iconPath: "Icon_Sports")
        let wheretoeat = Group(name: "Where To Eat", color: Config.Colors.FlatColors.pomegranate, iconPath: "Icon_Food")
        let excursions = Group(name: "Cool Excursions", color: Config.Colors.FlatColors.peterRiver, iconPath: "Icon_Earth")

        switch feedType.rawValue {
        case "personal":
            return [family, work, gym, bday]
        case "shared":
            return [wwdc, team]
        case "recommended":
            return [wheretoeat, excursions]
        default:
            return [family, work, gym, bday]
        }
    }
    
    private func loadDummyFavs(forGroup group: Group) {
        let oli         = Fav(givenName: "Oliver Barreto", familyName: "Barreto", value: "+34610700505", tag: "personal", type: "iPhone", imageName:"Oliver", groupName: group.name!)
        
        let oliMail         = Fav(givenName: "Oliver eMail", familyName: "Barreto", value: "oliver.barreto@gmail.com", tag: "personal", type: "eMail", imageName:"Oliver", groupName: group.name!)
        let oliverInnovation         = Fav(givenName: "Oliver Atos", familyName: "Atos ARI", value: "oliver.barreto@atos.net", tag: "Work", type: "eMail", imageName:"OliverInnovation", groupName: group.name!)
        let oliverInnovationText         = Fav(givenName: "Oliver Message", familyName: "Personal", value: "oliver.barreto@gmail.com", tag: "Work", type: "Text", imageName:"Oliver", groupName: group.name!)
        
        
        let ana         = Fav(givenName: "Ana Acosta", familyName: "Acosta", value: "+34670875979", tag: "personal", type: "iPhone", imageName:"Ana",  groupName: group.name!)
        
        let anaText         = Fav(givenName: "Ana Acosta", familyName: "Acosta", value: "+34670875979", tag: "personal", type: "Text", imageName:"Ana", groupName: group.name!)
        
        let anaFaceTime         = Fav(givenName: "Ana FaceTime", familyName: "Acosta", value: "+34670875979", tag: "personal", type: "FaceTime", imageName:"Ana", groupName: group.name!)
        
        let anaWhatsapp         = Fav(givenName: "Ana Whatsapp", familyName: "Acosta", value: "+34670875979", tag: "personal", type: "Whatsapp", imageName:"Ana", groupName: group.name!)
        
        let miguelBFaceTimeAudio = Fav(givenName: "Miguel FaceTimeAudio", familyName: "Acosta", value: "miguel.barretoacosta@gmail.com", tag: "personal", type: "FaceTimeAudio", imageName:"MiguelBA", groupName: group.name!)
        
        let mima        = Fav(givenName: "Mima Rodríguez", familyName: "Rodirguez", value: "+34697414021", tag: "personal", type: "Phone", imageName:"Mima", groupName: group.name!)
        
        let miguelB     = Fav(givenName: "Miguel Barreto", familyName: "Barreto", value: "+34636885214", tag: "personal", type: "Phone", imageName:"MiguelBA", groupName: group.name!)
        let miguelH     = Fav(givenName: "Miguel Herrera", familyName: "Herrera", value: "+34600281097", tag: "personal", type: "Phone", imageName:"MiguelHerrera",  groupName: group.name!)
        let raul        = Fav(givenName: "Raúl Barreto", familyName: "Barreto", value: "+34610700505", tag: "personal", type: "Phone", imageName:"RaulBA", groupName: group.name!)
        let mary        = Fav(givenName: "Mary Luis Peña", familyName: "Luis Peña", value: "+34670780741", tag: "personal", type: "Phone", imageName:"Mary", groupName: group.name!)
        let pureza      = Fav(givenName: "Colegio Pureza", familyName: "Pureza", value: "+34922277763", tag: "personal", type: "Phone", imageName:"PurezaMaria", groupName: group.name!)
        let restauranteLaHierbita = Fav(givenName: "La Hierbita", familyName: "Restaurante", value: "+34922244617", tag: "personal", type: "Phone", imageName:"Restaurante_LaHierbita", groupName: group.name!)
        let restauranteLaHierbitaMap = Fav(givenName: "La Hierbita", familyName: "Restaurante", value: "www.google.es/maps/place/Restaurante+La+Hierbita/@28.4661701,-16.25194,17z/data=!3m1!4b1!4m5!3m4!1s0xc41cb7da9cbb077:0xeb50cabbcc6989ec!8m2!3d28.4661701!4d-16.2497513", tag: "personal", type: "Map", imageName:"Restaurante_LaHierbita", groupName: group.name!)
        let restauranteLaHierbitaWeb = Fav(givenName: "La Hierbita", familyName: "Restaurante", value: "www.lahierbita.com", tag: "personal", type: "Web", imageName:"Restaurante_LaHierbita", groupName: group.name!)
        
        let restaurantePanzaBurroGastrotasca = Fav(givenName: "Panzaburro Gastrotasca", familyName: "Restaurante", value: "+34674962041", tag: "personal", type: "Phone", imageName:"Restaurante_Panzaburro", groupName: group.name!)
        let restauranteThai = Fav(givenName: "Tailandes Tarathai", familyName: "Restaurante", value: "+34922293698", tag: "restaurantes", type: "Phone", imageName:"Restaurante_Thai",  groupName: group.name!)
        let restauranteLibanes = Fav(givenName: "El Capricho Libanes", familyName: "Restaurante", value: "+34922252993", tag: "restaurantes", type: "Phone", imageName:"Restaurante_Libanes", groupName: group.name!)
        
        let bicisElParque = Fav(givenName: "Bicis El Parque", familyName: "Bicicletas", value: "+34942802292", tag: "Ocio", type: "Phone", imageName:"BicisElParque", groupName: group.name!)
        
        let telefericoElTeide = Fav(givenName: "Telférico El Teide", familyName: "Bicicletas", value: "+34922010440", tag: "Ocio", type: "Phone", imageName:"TelefericoElTeide",  groupName: group.name!)
        let wwdc2017         = Fav(givenName: "WWDC 2017", familyName: "Apple", value: "developersupport@apple.com", tag: "Work", type: "eMail", imageName:"WWDC", groupName: group.name!)
        
        
        guard let groupName = group.name else {return}
        
        switch groupName {
        case "Family", "Miguel's Birthday", "Nautico Team Party":
            favs.append(contentsOf: [ana, anaText, oli, miguelB, miguelH, raul, mima, mary, pureza, oliMail, anaFaceTime, miguelBFaceTimeAudio, anaWhatsapp])
        case "Work":
            favs.append(contentsOf: [oliverInnovation, oliverInnovationText])
        case "Gym":
            favs.append(contentsOf: [ana, oli])
        case "WWDC 2017":
            favs.append(contentsOf: [wwdc2017])
        case "Where To Eat", "Cool Excxursions":
            favs.append(contentsOf: [restauranteLaHierbita,restaurantePanzaBurroGastrotasca, restauranteLibanes, restauranteThai, restauranteLaHierbitaWeb, restauranteLaHierbitaMap])
        case "Cool Excursions":
            favs.append(contentsOf: [bicisElParque, telefericoElTeide])
        default:
            return
        }
    }
}
