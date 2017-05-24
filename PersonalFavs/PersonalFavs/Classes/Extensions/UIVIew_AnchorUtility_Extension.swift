//
//  UIVIew_AnchorUtility_Extension.swift
//  OnboardingWorkflow
//
//  Created by David Oliver Barreto Rodríguez on 24/12/16.
//  Copyright © 2016 David Oliver Barreto Rodríguez. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchorTo(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        
        anchorWithConstantsTo(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    
    func anchorWithConstantsTo(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0)  {
        
        _ = anchorWithSizeAndConstantsTo(top: top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    
    //: AnchorWithConstraintsTo - Utility Method
    func anchorWithSizeAndConstantsTo(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom:NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint]? {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(self.topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let left = left {
            anchors.append(self.leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        if let bottom = bottom {
            anchors.append(self.bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let right = right {
            anchors.append(self.rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        if widthConstant > 0 {
            anchors.append(self.widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if heightConstant > 0 {
            anchors.append(self.heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}

