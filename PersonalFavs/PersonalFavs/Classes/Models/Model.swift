//
//  Model.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 7/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

struct FavFeed {
    
    enum FeedType: String {
        case personal = "personal"
        case shared = "shared"
        case recommended = "recommended"
    }
    
    var feedType: FeedType!
    
    init(feedType: FeedType) {
        self.feedType = feedType
    }
}


class Group: NSObject, NSCoding {
    

    var name: String?
    var color: String?
    var iconPath: String?
    
    init(name: String, color: String, iconPath: String) {
        super.init()
        
        self.name = name
        self.color = color
        self.iconPath = iconPath
    }
    
    override var description: String {
        
        if let name = self.name, let color = self.color {
            let str = "Group Name: \(name), Color: \(color)"
            return str
        }
        return "Empty"
    }
    
    // MARK: NSCoding Protocol
    private struct GroupNSCodingProtocol {
        static let keyForName = "name"
        static let keyForColor = "color"
        static let keyForIconPath = "iconPath"
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: GroupNSCodingProtocol.keyForName) as? String,
            let color = decoder.decodeObject(forKey: GroupNSCodingProtocol.keyForColor) as? String,
            let iconPath = decoder.decodeObject(forKey: GroupNSCodingProtocol.keyForIconPath) as? String else {return nil}
        
        self.init(name: name, color: color, iconPath: iconPath)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: GroupNSCodingProtocol.keyForName)
        coder.encode(color, forKey: GroupNSCodingProtocol.keyForColor)
        coder.encode(iconPath, forKey: GroupNSCodingProtocol.keyForIconPath)
    }
}

class Fav: NSObject, NSCoding {

    var givenName: String?
    var familyName: String?
    var type: String?
    var tag: String?
    var value: String?
    var imageName: String?
    
//    var group: Group?
    var groupName: String?
    
    init (givenName: String, familyName: String, value: String, tag: String, type: String, imageName: String, groupName: String) {
        super.init()
        
        self.givenName = givenName
        self.familyName = familyName
        self.value = value
        self.tag = tag
        self.type = type
        self.imageName = imageName
//        self.group = group
        self.groupName = groupName
    }
    
    override var description: String {
        
        if let givenName = self.givenName, let familyName = self.familyName, let value = self.value, let groupName = self.groupName {
            let str = "Fav Name: \(givenName) \(familyName), Value: \(value), Group: \(groupName)"
            return str
        }
        return "Empty Fav"
    }
    
    // MARK: NSCoding Protocol
    private struct FavNSCodingProtocol {
        static let keyForGivenName = "givenName"
        static let keyForFamilyName = "familyName"
        static let keyForValue = "value"
        static let keyForTag = "tag"
        static let keyForType = "type"
        static let keyForImageName = "imageName"
//        static let keyForGroup = "group"
        static let keyForGroupName = "groupName"
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let givenName = decoder.decodeObject(forKey:FavNSCodingProtocol.keyForGivenName) as? String,
            let familyName = decoder.decodeObject(forKey: FavNSCodingProtocol.keyForFamilyName) as? String,
            let value = decoder.decodeObject(forKey: FavNSCodingProtocol.keyForValue) as? String,
            let tag = decoder.decodeObject(forKey: FavNSCodingProtocol.keyForTag) as? String,
            let type = decoder.decodeObject(forKey: FavNSCodingProtocol.keyForType) as? String,
            let imageName = decoder.decodeObject(forKey: FavNSCodingProtocol.keyForImageName) as? String,
            let groupName = decoder.decodeObject(forKey: FavNSCodingProtocol.keyForGroupName) as? String
            else {return nil}
        
        self.init(givenName: givenName, familyName: familyName, value: value, tag: tag, type: type, imageName: imageName, groupName: groupName)
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(givenName, forKey: FavNSCodingProtocol.keyForGivenName)
        coder.encode(familyName, forKey: FavNSCodingProtocol.keyForFamilyName)
        coder.encode(value, forKey: FavNSCodingProtocol.keyForValue)
        coder.encode(tag, forKey: FavNSCodingProtocol.keyForTag)
        coder.encode(type, forKey: FavNSCodingProtocol.keyForType)
        coder.encode(imageName, forKey: FavNSCodingProtocol.keyForImageName)
//        coder.encodeConditionalObject(group, forKey: FavNSCodingProtocol.keyForGroup)
        coder.encode(groupName, forKey: FavNSCodingProtocol.keyForGroupName)
    }
}

