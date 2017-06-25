//
//  HomeViewControllerTransitionManager.swift
//  PersonalFavs
//
//  Created by David Oliver Barreto Rodríguez on 24/6/17.
//  Copyright © 2017 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

class HomeViewControllerTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {

    // MARK: - UIViewControllerAnimatedTransitioning Protocol Methods
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // TODO: Perform Animation
        
        let container = transitionContext.containerView
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to)  else { return }
        
        
        // set up from 2D transforms that we'll use in the animation
        let offScreenRight = CGAffineTransform(translationX: container.frame.width, y: 0)
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0)
        
        // Animation starts with toView just outside to the right of the screen
        toView.transform = offScreenRight
        
        // add the both views to our view controller
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // get the duration of the animation
        // DON'T just type '0.5s' -- the reason why won't make sense until the next post
        // but for now it's important to just follow this approach
        let duration = self.transitionDuration(using: transitionContext)
        
        // perform the animation!
        // for this example, just slid both fromView and toView to the left at the same time
        // meaning fromView is pushed off the screen and toView slides into view
        // we also use the block animation usingSpringWithDamping for a little bounce
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            
            fromView.transform = offScreenLeft
            fromView.alpha = 0
            toView.transform = CGAffineTransform.identity
            
        }, completion: { finished in
            
            // tell our transitionContext object that we've finished animating
            transitionContext.completeTransition(true)
            
        })
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    
    // MARK: - UIViewControllerTransitioningDelegate Protocol Methods
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}
