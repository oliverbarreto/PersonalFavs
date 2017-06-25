//
//  NavigationControllerDelegateForCustomTransitions.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 24/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class NavDelegate: NSObject, UINavigationControllerDelegate {
    
    private let animator = HomeViewControllerTransitionManager()
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}

