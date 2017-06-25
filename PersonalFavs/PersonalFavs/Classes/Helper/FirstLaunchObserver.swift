//
//  FirstLaunchObserver.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 24/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

final class FirstLaunchObserver {
    
    private let userDefaults = UserDefaults.standard
    private let keyForUserDefault = "com.oliverbarreto.FirstLaunchObserver.WasLaunchedBefore"
    
    private let wasLaunchedBefore: Bool    // Will be loaded from UserDefaults
    public var isFirstLaunch:Bool {        // Exposes the value to outside
        return !wasLaunchedBefore
    }
    
    init() {
        let wasLaunchedBefore = userDefaults.bool(forKey: keyForUserDefault)
        self.wasLaunchedBefore = wasLaunchedBefore
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: keyForUserDefault)
        }
    }
}
